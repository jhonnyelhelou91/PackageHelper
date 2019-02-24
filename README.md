# Package Helpers

PowerShell Helper scripts to manage NuGet packages.

## Getting Started

* Copy the files
* Open Command Line or PowerShell (*Window + X, A*)
* If you opened Command Prompt, then type *powershell* in order to use PowerShell commands
* Navigate to the scripts directory <br />`cd your_directory`
* Type <br />`Import-Module .\PackageHelper.psm1`
* Now you can use the methods from your PowerShell session

### Adding Script to Profile [Optional]

* Enable execution policy using PowerShell Admin <br /> `Set-ExecutionPolicy Unrestricted`
* Navigate to the profile path <br />`cd (Split-Path -parent $PROFILE)`
* Open the location in Explorer <br />`ii .`
* Create the user profile if it does not exist <br />`If (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }`
* Import the module in the PowerShell profile <br />`Import-Module -Path script_directory -ErrorAction SilentlyContinue`

# Examples

## Update-Nuspec Example
Update Nuspec config to match the same versions specified in app.config.
<details>
   <summary>Update Nuspec.config in current directory</summary>
   <p>Update-Nuspec</p>
</details>
<details>
   <summary>Update Nuspec.config by path</summary>
   <p>Update-Nuspec -Path 'C:\git\PowerShell\EnvironmentVariables\'</p>
</details>
<details>
   <summary>Update Nuspec.config by repository name</summary>
   <p>Update-Nuspec -Repository 'EnvironmentVariables'</p>
</details>

## Find-Package Example
Find all package(s) that match the specified pattern.
<details>
   <summary>Get all packages for current directory</summary>
   <p>Find-Package</p>
</details>
<details>
   <summary>Get Microsoft packages for current directory</summary>
   <p>Find-Package -Pattern '*Microsoft*'</p>
</details>
<details>
   <summary>Get all packages by path</summary>
   <p>Update-Nuspec -Path 'C:\git\PowerShell\EnvironmentVariables\'</p>
</details>
<details>
   <summary>Get Microsoft packages for current directory</summary>
   <p>Find-Package -Path 'C:\git\PowerShell\EnvironmentVariables\' -Pattern '*Microsoft*'</p>
</details>
<details>
   <summary>Get packages by major versionfor current directory</summary>
   <p>Find-Package -Path 'C:\git\PowerShell\EnvironmentVariables\' -Pattern '*2.*'</p>
</details>
<details>
   <summary>Get packages by major/minor version for current directory</summary>
   <p>Find-Package -Path 'C:\git\PowerShell\EnvironmentVariables\' -Pattern '*2.1*'</p>
</details>
<details>
   <summary>Get all packages for repository name</summary>
   <p>Find-Package -Repository 'EnvironmentVariables'</p>
</details>
<details>
   <summary>Get Microsoft packages for repository name</summary>
   <p>Find-Package -Repository 'EnvironmentVariables' -Pattern '*Microsoft*'</p>
</details>
<details>
   <summary>Get packages by major version for repository name</summary>
   <p>Find-Package -Repository 'EnvironmentVariables' -Pattern '*2.*'</p>
</details>
<details>
   <summary>Get packages by major/minor version for repository name</summary>
   <p>Find-Package -Repository 'EnvironmentVariables' -Pattern '*2.1*'</p>
</details>
