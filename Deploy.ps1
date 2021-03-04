[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $BucketName,
    [Parameter()]
    [string]
    $Region = "us-east-1",
    [Parameter()]
    [switch]$Build
)

if ($Build -eq $True) {
    Write-Host "Building Angular App"
    ng build
}

Write-Host "Creating/Ensuring S3 bucket"
aws s3api create-bucket --bucket $BucketName --region $Region

Write-Host "Enabling website hosting"
aws s3 website "s3://$($BucketName)/" --index-document index.html --error-document error.html

Write-Host "Enabling public access to bucket contents via policy"
aws s3api put-bucket-policy --bucket $BucketName --policy file://aws/bucket-policy.json

Write-Host "Copying website artefacts"
aws s3 cp .\dist\todo-app\ "s3://$($BucketName)" --recursive

Write-Host "Done. webiste-url: https://$($BucketName).s3.amazonaws.com"

