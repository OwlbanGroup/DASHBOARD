# Verify Python syntax
Set-Location "c:/Users/bizle/OneDrive/Documents/GitHub/DASHBOARD/quickstart/python"
python -m py_compile server.py
if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS: Python syntax is valid"
    exit 0
} else {
    Write-Host "ERROR: Python syntax error found"
    exit 1
}
