$ErrorActionPreference = 'Stop'
go mod tidy
go build -trimpath -ldflags "-s -w" -o arduino-manager-gui.exe .
Write-Host "Built: .\arduino-manager-gui.exe"
