[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $BucketName,
    [Parameter()]
    [string]
    $Region = "us-east-1",
    [Parameter()]
    [switch]$Build,
    [Parameter()]
    [switch]$UseCloudFront
)

if ($Build -eq $True) {
    Write-Host "Building Angular App"
    ng build
}

Write-Host "Creating/Ensuring S3 bucket"
aws s3api create-bucket --bucket $BucketName --region $Region

Write-Host "Enabling public access to bucket contents via policy"
aws s3api put-bucket-policy --bucket $BucketName --policy file://aws/bucket-policy.json

Write-Host "Copying website artefacts"
aws s3 cp .\dist\todo-app\ "s3://$($BucketName)" --recursive


if($UseCloudFront -eq $false) {
    Write-Host "Enabling website hosting"
    aws s3 website "s3://$($BucketName)/" --index-document index.html --error-document error.html
    Write-Host "Done. webiste-url: https://$($BucketName).s3.amazonaws.com"
}else {
    Write-Host "Checking if CloudFront distribution exists"
    $listResult = aws cloudfront list-distributions --query "DistributionList.Items[?contains(Origins.Items[*].DomainName, '$($BucketName).s3.amazonaws.com')].DomainName" | ConvertFrom-Json
    if($listResult.Count -gt 0) {
        Write-Host "Done. CloudFront distribution already exists"
        Write-Host "website-url: https://$($listResult[0])"
    }else {
        Write-Host "Creating CloudFront distribution"
        $createResult = aws cloudfront create-distribution --origin-domain-name "$($BucketName).s3.amazonaws.com" --default-root-object index.html | ConvertFrom-Json
        Write-Host "Done. webisite-url: https://$($createResult.Distribution.DomainName)"    
    }
}


