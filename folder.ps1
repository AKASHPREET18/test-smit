function Grant-FullControlToAssetsFolder {
    # Define the folder path
    $folderPath = "C:\pcc\wwwroot\guides.ui\assets"

    # Define the identity for the Users group
    $identity = "Users"  # You can use the full identity if necessary, e.g., "MT-LAP-042\Users"

    try {
        # Get the existing access control settings
        $acl = Get-Acl -Path $folderPath

        # Remove any existing access rules for the Users group
        $acl.Access | Where-Object { $_.IdentityReference -eq $identity } | ForEach-Object { $acl.RemoveAccessRule($_) }

        # Create a new access rule for Full Control
        $fileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        
        # Add the new access rule
        $acl.AddAccessRule($fileSystemAccessRule)

        # Apply the updated ACL to the folder
        Set-Acl -Path $folderPath -AclObject $acl

        Write-Host "Full Control permissions granted to $identity for folder ==> $folderPath"
    } catch {
        Write-Host "An error occurred: $_"
        exit 1
    }
}

# Call the function to execute it
Grant-FullControlToAssetsFolder
