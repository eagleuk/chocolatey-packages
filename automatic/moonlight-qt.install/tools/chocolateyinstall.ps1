﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  file          = "$toolsDir\MoonlightSetup-4.2.1.exe"  
  silentArgs	= '/S'
}

Install-ChocolateyInstallPackage @packageArgs
