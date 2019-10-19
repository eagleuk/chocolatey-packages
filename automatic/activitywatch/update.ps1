import-module au

function global:au_GetLatest {	
     $github_repository = "ActivityWatch/activitywatch"
     $releases = "https://github.com/" + $github_repository + "/releases"

     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regex   = $github_repository + '/releases/download/.*/activitywatch[-_]v(?<Version>.*)-windows-x86_64.zip'
	$url = $download_page.links | ? href -match $regex | Select -First 1
	
     return @{ 
       Version = $matches.Version -Replace 'b','-beta'
       URL32 = "https://github.com" + $url.href
     }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
			"(^(\s)*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

update
