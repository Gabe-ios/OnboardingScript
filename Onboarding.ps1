#Get access to the file, imports CSV.
$ImportCSV = Import-Csv -Path "C:\Users\VboxUser\Documents\NewClients.csv"

#run a loop to iterate through each user.
foreach ($User in $ImportCSV) {

    #Checks the given description of the user, then alters parameters per user. 
    if($User.Description -eq "Client"){
        $UserInfo = @{
            SamAccountName = $User.SamAcc
            Name = $User.MemberName + " " + $User.LastName
            Surname = $User.LastName
            GivenName = $User.GivenName
            Description = $User.Description
            #Identifies where to place the profile.
            Path = "OU=Client Users,OU=Users,OU=FocusDiv1,dc=focus,dc=local"
        }
        $newUser = New-ADUser @UserInfo -PassThru
        Write-Host "Creating User:" $User.GivenName
        #Creates the user, then assigns corresponding security group.
        Add-ADGroupMember -Identity "Client Users" -Members $newUser

    } elseif ($User.Description -eq "Marketing") {
        $UserInfo = @{
            SamAccountName = $User.SamAcc
            Name = $User.MemberName + " " + $User.LastName
            Surname = $User.LastName
            GivenName = $User.GivenName
            Description = $User.Description
            Path = "OU=Marketing,OU=Users,OU=FocusDiv1,dc=focus,dc=local"
        }
        $newUser = New-ADUser @UserInfo -PassThru
        Write-Host "Creating User:" $User.GivenName
        Add-ADGroupMember -Identity "Marketing Team" -Members $newUser

    } elseif($User.Description -eq "Admin"){
        $UserInfo = @{
            SamAccountName = $User.SamAcc
            Name = $User.MemberName + " " + $User.LastName
            Surname = $User.LastName
            GivenName = $User.GivenName 
            Description = $User.Description
            Path = "OU=Admin Users,OU=Users,OU=FocusDiv1,dc=focus,dc=local"
        }
        $newUser = New-ADUser @UserInfo -PassThru
        Write-Host "Creating User:" $User.GivenName
        Add-ADGroupMember -Identity "Admin Users" -Members $newUser
    } else{
        $UserInfo = @{
            SamAccountName = $User.SamAcc
            Name = $User.MemberName + " " + $User.LastName
            Surname = $User.LastName
            GivenName = $User.GivenName
            Description = $User.Description
            Path = "OU=ManualAssign,OU=Users,OU=FocusDiv1,dc=focus,dc=local"
        }
        New-ADUser @UserInfo
    }
}
