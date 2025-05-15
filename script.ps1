# PowerShell Script to Check and Install AWS CLI v2

$awsCliUrl = "https://awscli.amazonaws.com/AWSCLIV2.msi"
$awsCliInstaller = "$env:TEMP\AWSCLIV2.msi"

# Function to check if AWS CLI is installed
function Is-AwsCliInstalled {
    try {
        $version = aws --version 2>$null
        return $version -ne $null
    } catch {
        return $false
    }
}

# Main logic
if (Is-AwsCliInstalled) {
    Write-Output "AWS CLI is already installed."
} else {
    Write-Output "AWS CLI not found. Downloading and installing..."

    # Download the installer
    Invoke-WebRequest -Uri $awsCliUrl -OutFile $awsCliInstaller

    # Install silently
    Start-Process msiexec.exe -ArgumentList "/i `"$awsCliInstaller`" /qn" -Wait

    # Verify installation
    if (Is-AwsCliInstalled) {
        Write-Output "AWS CLI installed successfully."
    } else {
        Write-Output "AWS CLI installation failed."
    }
}

# login to aws repo
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 558300632343.dkr.ecr.us-east-1.amazonaws.com
# run docker build
docker build -t flask-crud C:\Schooljaar_2024-2025\Cloud_platform\Assignment3\docker\frontend\.
docker tag flask-crud 558300632343.dkr.ecr.us-east-1.amazonaws.com/flask-crud-repository:latest
docker push 558300632343.dkr.ecr.us-east-1.amazonaws.com/flask-crud-repository:latest

aws ecr create-repository --repository-name flask-crud-repository --region us-east-1

docker build -t flask-crud C:\Schooljaar_2024-2025\Cloud_platform\Assignment3\docker\frontend\.
docker run -d -p 80:80 -e DATABASE_URL=db-flask-crud.c9yogumocsuq.us-east-1.rds.amazonaws.com -e DATABASE_USERNAME=flaskcrud -e DATABASE_PASSWORD=flaskcrud --name flask-crud-app flask-crud
  flask-crud
