$sourceDir = "../scripts/"
$outputFile = "./lambda_function.zip"

# Remove existing ZIP file if it exists
if (Test-Path $outputFile) {
    Remove-Item $outputFile
}

# Create new ZIP file
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($sourceDir, $outputFile)
