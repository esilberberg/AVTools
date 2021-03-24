# Run from inside a directory to convert all .mkv, .mp4, or .avi files to .gif and organizes outputs
function Get-MediaType 
{
      Write-Host '~*~ BatchGifer ~*~' -ForegroundColor red -BackgroundColor white
      Write-Host "Press 1 for .mkv (default)"
      Write-Host "Press 2 for .mp4"
      Write-Host "Press 3 for .avi"
      $media = Read-Host "Choose a media type"
      switch ($media) {
            1 {$chosenMedia = "*.mkv"  }
            2 {$chosenMedia = "*.mp4"  }
            3 {$chosenMedia = "*.avi"  }
            Default {1}
      }
      return $chosenMedia
}

$videos = Get-MediaType | Get-ChildItem -Filter $chosenMedia

$outputFolder = ".\gifs"
If(!(Test-Path $outputFolder))
{
      New-Item -ItemType Directory -Force -Path $outputFolder
}

$palettesFolder = ".\palettes"
If(!(Test-Path $palettesFolder))
{
      New-Item -ItemType Directory -Force -Path $palettesFolder
}

foreach ($v in $videos)
{
    ffmpeg -hide_banner -i $v -filter_complex "fps=10,scale=500:-1:flags=lanczos,palettegen" palette.png | 
    ffmpeg -hide_banner -i $v -i palette.png -filter_complex "[0:v]fps=10, scale=500:-1:flags=lanczos[v], [v][1:v]paletteuse" -loop 0 "$($v.basename).gif"
    
    Get-ChildItem -Filter *.gif | Move-Item -Destination $outputFolder
    Get-ChildItem -Filter palette.png | Rename-Item -NewName {$_.Basename.Replace("palette","$($v.basename)") + $_.extension} -PassThru | Move-Item -Destination $palettesFolder
}




