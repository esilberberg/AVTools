Write-Host "++++++++++++++++++ Welcome to Batch2MOV ++++++++++++++++++" -ForegroundColor Black -BackgroundColor Yellow
$path = Read-Host -Prompt "Please copy and paste the directory here"

$output_dir = "MOV_converts"

if (Test-Path -Path "$path\$output_dir") {
    Write-Host "++++++++++++++++++ Using the existing $output_dir directory ++++++++++++++++++" -ForegroundColor Black -BackgroundColor Yellow
} else {
    New-Item -Path $path -Name $output_dir -ItemType "directory"
    Write-Host "++++++++++++++++++ Created the output directory: $output_dir ++++++++++++++++++" -ForegroundColor Black -BackgroundColor Yellow
}

$videos = Get-ChildItem -Path $path -Filter *.mp4

foreach ($v in $videos) {
    ffmpeg -hide_banner -i "$path\$v" -vcodec copy -acodec copy "$path\$output_dir\$($v.basename).mov"

    Write-Host "++++++++++++++++++ $($v.basename).mov ++++++++++++++++++" -ForegroundColor Black -BackgroundColor Yellow
}
Write-Host "++++++++++++++++++ END Batch2MOV ++++++++++++++++++" -ForegroundColor Black -BackgroundColor Yellow