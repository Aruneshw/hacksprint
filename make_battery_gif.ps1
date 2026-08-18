Add-Type -AssemblyName System.Drawing

$assetDir = Join-Path (Get-Location) 'battery_safety_assets'
$outFile = Join-Path $assetDir 'intelligent_battery_safety_explainer.gif'
$W=1280; $H=720
$scenes = @(
  @{File='photo_2.png'; Title='INTELLIGENT BATTERY SAFETY'; Sub='Sensor-fused monitoring for early fault detection'; Accent=[System.Drawing.Color]::FromArgb(0,210,180)},
  @{File='photo_3.png'; Title='FROM SENSORS TO AI'; Sub='Voltage • current • temperature • strain • vibration • gas'; Accent=[System.Drawing.Color]::FromArgb(70,150,255)},
  @{File='photo_2.png'; Title='PREDICT. PROTECT. RESPOND.'; Sub='GREEN: normal   YELLOW: cool & reduce power   RED: isolate & suppress'; Accent=[System.Drawing.Color]::FromArgb(255,190,30)}
)

function New-Frame($scene, $zoom) {
  $bmp = New-Object System.Drawing.Bitmap($W,$H)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.Clear([System.Drawing.Color]::FromArgb(8,14,24))
  $src=[System.Drawing.Image]::FromFile((Join-Path $assetDir $scene.File))
  $scale=[Math]::Max($W/$src.Width,$H/$src.Height)*$zoom
  $dw=$src.Width*$scale; $dh=$src.Height*$scale
  $x=($W-$dw)/2; $y=($H-$dh)/2
  $g.DrawImage($src,$x,$y,$dw,$dh)
  $overlay=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(125,0,0,0)); $g.FillRectangle($overlay,0,0,$W,$H); $overlay.Dispose()
  $accentBrush=New-Object System.Drawing.SolidBrush($scene.Accent)
  $g.FillRectangle($accentBrush,0,0,14,$H); $accentBrush.Dispose()
  $font1=New-Object System.Drawing.Font('Arial',36,[System.Drawing.FontStyle]::Bold)
  $font2=New-Object System.Drawing.Font('Arial',22,[System.Drawing.FontStyle]::Regular)
  $white=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
  $accentBrush=New-Object System.Drawing.SolidBrush($scene.Accent)
  $g.DrawString($scene.Title,$font1,$white,52,52)
  $g.DrawString($scene.Sub,$font2,$accentBrush,55,112)
  $g.FillRectangle((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(185,0,0,0))),40,610,1200,75)
  $small=New-Object System.Drawing.Font('Arial',20,[System.Drawing.FontStyle]::Regular)
  $g.DrawString('Intelligent Battery-Pack Safety & Early-Fault Detection System',$small,$white,60,628)
  $src.Dispose(); $font1.Dispose(); $font2.Dispose(); $small.Dispose(); $white.Dispose(); $accentBrush.Dispose(); $g.Dispose()
  return $bmp
}

$frames = New-Object System.Collections.Generic.List[System.Drawing.Bitmap]
foreach($s in $scenes){ for($i=0;$i -lt 12;$i++){ $frames.Add((New-Frame $s (1.0 + 0.035*$i))) } }
$enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object {$_.MimeType -eq 'image/gif'}
$ep=New-Object System.Drawing.Imaging.EncoderParameters(1)
$ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::SaveFlag,[long][System.Drawing.Imaging.EncoderValue]::MultiFrame)
$delay=New-Object byte[] (4*$frames.Count); for($i=0;$i -lt $frames.Count;$i++){ [BitConverter]::GetBytes([int]15).CopyTo($delay,4*$i) }
$prop=[System.Runtime.Serialization.FormatterServices]::GetUninitializedObject([System.Drawing.Imaging.PropertyItem]); $prop.Id=0x5100; $prop.Type=4; $prop.Len=$delay.Length; $prop.Value=$delay; $frames[0].SetPropertyItem($prop)
$frames[0].Save($outFile,$enc,$ep)
$ep.Param[0].Dispose(); $ep.Dispose()
$ep=New-Object System.Drawing.Imaging.EncoderParameters(1); $ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::SaveFlag,[long][System.Drawing.Imaging.EncoderValue]::FrameDimensionTime)
for($i=1;$i -lt $frames.Count;$i++){ $frames[0].SaveAdd($frames[$i],$ep) }
$ep.Param[0].Dispose(); $ep.Dispose(); $ep=New-Object System.Drawing.Imaging.EncoderParameters(1); $ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::SaveFlag,[long][System.Drawing.Imaging.EncoderValue]::Flush); $frames[0].SaveAdd($ep); $ep.Param[0].Dispose(); $ep.Dispose()
foreach($f in $frames){$f.Dispose()}
Write-Output $outFile
