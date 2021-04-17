#Run inside the directory plus drag and drop desired image to create single image video

Write-Host '~*~ Single Image Cinema ~*~' -ForegroundColor black -BackgroundColor yellow
$image = Read-Host -Prompt "Drag and drop the image"

$tracks = Get-Childitem -Filter *.mp3



$outputFolder = ".\SingleImageCinema"
If(!(Test-Path $outputFolder))
{
      New-Item -ItemType Directory -Force -Path $outputFolder
}

foreach ($track in $tracks) {
    ffmpeg -loop 1 -y -i $image -i $track -shortest -acodec copy -vcodec mjpeg "$($track.basename).mp4"
    Get-ChildItem -Filter *.mp4 | Move-Item -Destination $outputFolder
}

$count = (Get-Childitem -Path $outputFolder -Filter *.mp4).count

Write-Host "Single Image Cinema created $count videos " -ForegroundColor black -BackgroundColor green