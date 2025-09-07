# this script scan all picture in current dir, output to a text file

# require ImageMagick
# require Tesseract
# ----------------------------------------------


param(
    [Parameter(Mandatory, HelpMessage = "directory to process; e.g.  .")]
    [string]$dir,
    [Parameter(Mandatory, HelpMessage = "output dir; e.g. ./temp/")]
    [string]$outputDir
)
Set-StrictMode -Version Latest

# 0. show commands when run
Set-PSDebug -Trace 1

if (-not (Test-Path -Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory
}

# 1. convert and normalize pictures to black&white high quality text image
## resize to half (too big no good)
Get-ChildItem -Path "$dir/*" -File -Include "*.png", "*.jpg", "*.jpeg" | ForEach-Object { magick $_.FullName -colorspace gray -sharpen 0x1 -normalize -threshold 50% -resize 50% -sharpen 0x1 -bordercolor white -border 16 ("$outputDir/" + $_.Name) } 



# 2. scan image and convert to text 

## set current session to use UTF-8 encoding (for piping)
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

## exec
Get-ChildItem -Path "$outputDir/*" -File -Include "*.png", "*.jpg", "*.jpeg"  | ForEach-Object { tesseract $_.FullName stdout --oem 1 --psm 6 -c preserve_interword_spaces=1 -l eng } > "$outputDir/output.txt"

# # for separate .txt files
# cd $outputDir
# Get-ChildItem -Path "./*" -File -Include "*.png", "*.jpg", "*.jpeg"  | ForEach-Object { tesseract $_.FullName $_.BaseName --oem 1 --psm 6 -c preserve_interword_spaces=1 -l eng }
# Get-Content *.txt | Set-Content output.txt

# reference: (Tesseract)
# https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html
# trained language data:  https://github.com/tesseract-ocr/tessdata_best