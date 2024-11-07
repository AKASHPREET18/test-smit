function Grant-FullControlToAssetsFolder {
    # Define the folder path
    $folderPath = "C:\pcc\wwwroot\guides.ui\assets"
    
    # Define the identity for the Users and Everyone groups
    $identities = @("Users", "Everyone")	
    
    # Get the existing access control settings
    $acl = Get-Acl -Path $folderPath
    
    # Loop through each identity and add "Full Control" permissions
    foreach ($identity in $identities) {
        $fileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($fileSystemAccessRule)
    }
    
    # Apply the updated ACL to the folder
    Set-Acl -Path $folderPath -AclObject $acl

    Write-Host "Permissions granted to Users and Everyone groups for folder ==> $folderPath"
}
