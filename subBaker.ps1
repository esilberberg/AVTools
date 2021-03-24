# Bakes subtitles on output video with option to trim video

$video = Read-Host -Prompt "Enter the video file"
$subtitlePath = Read-Host -Prompt "Enter the subtitle file"
$start = Read-Host -Prompt "Enter the start time (optional)"
$end = Read-Host -Prompt "Enter the end time (optional)"

$videoBaseName = [io.path]::GetFileNameWithoutExtension($video)
$videoName = Split-Path -Path "$video" -Leaf
$subtitleName = Split-Path -Path "$subtitlePath" -Leaf

if ( $start -eq '' )
{
    $start = '00:00:00'
}

if ( $end -eq '' )
{
    $end = ffprobe -v error -show_entries format=duration -sexagesimal -of default=noprint_wrappers=1:nokey=1 $video
}


ffmpeg -i $video -filter_complex subtitles=$subtitleName -ss $start -to $end "$($videoBaseName)_sub-trim.mp4"

Write-Host "You selected to bake subtitle file $subtitleName on video $videoName, starting at $start and ending at $end." -ForegroundColor black -BackgroundColor yellow
