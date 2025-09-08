<#
.SYNOPSIS
    this script scan all picture in a dir, output to text files
.DESCRIPTION
    dependencies:
      require ImageMagick
      require Tesseract
.LINK
    references: 
    * ImageMagick
        - param arguments:  https://imagemagick.org/script/command-line-options.php
    * Tesseract
        - improve quality:  https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html
        - trained language data:  https://github.com/tesseract-ocr/tessdata_best
.EXAMPLE
    image-to-text . outputDir -language eng -resizePercentage 50% -combineOutputFile y
.EXAMPLE
    image-to-text . outputDir -language eng+equ -resizePercentage 25% -combineOutputFile n
#>
param(
    [switch]$help,

    [Parameter(Mandatory, HelpMessage = "directory to process; e.g.  .")]
    [ArgumentCompleter({ "." })]
    [string]$dir,

    [Alias("o")]
    [Parameter(Mandatory, HelpMessage = "output dir; e.g. ./outputDir/")]
    [ArgumentCompleter({ "outputDir" })]
    [string]$outputDir,
    
    [Parameter(Mandatory, HelpMessage = "language of tesseract .traineddata (e.g.: eng)")]
    [ArgumentCompleter({ "eng", "eng+equ" })]
    [string]$language = "eng",

    [Parameter(Mandatory, HelpMessage = "resize preprocessed images, too big no good (e.g. 50%)")]
    [ArgumentCompleter({ "50%", "25%" })]
    [string]$resizePercentage="50%",

    [Parameter(Mandatory, HelpMessage = "yes or no?")]
    [ValidateSet("y", "n")]
    [ArgumentCompleter({ "y", "n" })]
    [char]$combineOutputFile
)
Set-StrictMode -Version Latest

if ($help) {
    # display help
    Get-Help $MyInvocation.MyCommand.Name
    exit 0;
}


# 0. show commands when run
Set-PSDebug -Trace 1

if (-not (Test-Path -Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory
}

# 1. convert and normalize pictures to black&white high quality text image
## and resize image (too big no good)
Get-ChildItem -Path "$dir/*" -File -Include "*.png", "*.jpg", "*.jpeg" | ForEach-Object { magick $_.FullName -colorspace gray -sharpen 0x1 -normalize -threshold 50% -resize $resizePercentage -sharpen 0x1 -bordercolor white -border 16 ("$outputDir/" + $_.Name) } 



# 2. scan image and convert to text 

## set current session to use UTF-8 encoding (for piping)
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

## exec
if ($combineOutputFile -eq "y") {
    Get-ChildItem -Path "$outputDir/*" -File -Include "*.png", "*.jpg", "*.jpeg"  | ForEach-Object { tesseract $_.FullName stdout --oem 1 --psm 6 -c preserve_interword_spaces=1 -l $language } > "$outputDir/output.txt"
}
else {
    ## for separate .txt files
    Get-ChildItem -Path "$outputDir/*" -File -Include "*.png", "*.jpg", "*.jpeg"  | ForEach-Object { tesseract $_.FullName ("$outputDir/" + $_.BaseName) --oem 1 --psm 6 -c preserve_interword_spaces=1 -l $language }
}

# reference: (Tesseract)
# https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html
# trained language data:  https://github.com/tesseract-ocr/tessdata_best