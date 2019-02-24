$ErrorActionPreference = "Stop"
function Update-Nuspec {
Param(
	[string]
	$path = '.',

	[string]
	$repository
);

    If (![string]:IsNullOrEmpty($repository))
	{
		$path = (Get-Item "Env:Dev.Repository_$repository.Path").Value;
	}
	
	Write-Host "Find all nupsec in path $path"
	$nuspec_files = Get-ChildItem -Path "$path"	-Filter "*.nuspec" -Recurse -Exclude .git

	Foreach ($nuspec_file in $nuspec_files) {
		Write-Host "Updating $($nuspec_file.Name)..."

		$package_config_path = Join-Path -Path "$($nuspec_file.Directory)" -ChildPath "packages.config";
	
		if(-Not (Test-Path $package_config_path)) { 
			Write-Host "packages.config was not found with path $package_config_path";
			return; 
		}

		$nuspec_file_content = Get-Content $nuspec_file;
		$packages = Select-String -Path "$package_config_path" -Pattern '<package .* />';
		$new_dependencies = "";
		
		Foreach ($package in $packages) {
			$new_dependencies = $new_dependencies + $package.line -replace '<package id="(.*?)".* version="(.*?)".*', '`t<dependency id="$1" version="[$2]" />';
		}
		$new_dependencies = ($new_dependencies | Out-String).Trim();

		If ($nuspec_file_content -eq $null) {
			$start = '<dependencies>';
			$end = '</dependencies>';
		} Else {
			$start_index = $nuspec_file_content.IndexOf('<dependencies>');
			If ($start_index -ge 0) {
				$start = $nuspec_file_content.Substring(0, $start_index).Trim();
			} Else {
				$start = '<dependencies>';
			}
			
			$end_index = $nuspec_file_content.IndexOf('</dependencies>');
			If ($end_index -ge 0) {
				$end = $nuspec_file_content.Substring($end_index).Trim();
			} Else {
				$end = '</dependencies>';
			}
		}
		
		$nuspec_file_content = "$start`n$new_dependencies`n$end";
		Set-Content -Path '$nuspec_file' -Value $nuspec_file_content
	}
}
function Find-Package {
Param(
	[string]
	$path = '.',
	
	[string]
	$repository,
	
    [string]
    $pattern = '*'
);
    
    If (![string]:IsNullOrEmpty($repository))
	{
		$path = (Get-Item "Env:Dev.Repository_$repository.Path").Value;
	}

    $packages = Get-ChildItem -Path "$path" -Filter "packages.config" -Recurse;
	
    Foreach($package_file in $packages)
	{
		Write-Host "Searching for pattern $pattern in $($package_file.FullName)";
		
        [xml]$xmlContent = Get-Content -Path "$($package_file.FullName)";
		$dependent_packages = $xmlContent.packages.package;

		Foreach ($pkg in $dependent_packages)
		{
			$id = $pkg.id;
			$version = $pkg.version;
			$targetFramework = $pkg.targetFramework;
			
			if ($id -match $pattern -or $version -match $pattern -or $pkg.targetFramework -match $pattern) {
				Write-Host "Keyword ($pattern) matched for $id.$version $targetFramework";
			}
		};
    }
}

export-modulemember -function Update-Nuspec
export-modulemember -function Find-Package
