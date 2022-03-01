$data=Import-Csv "C:\Users\Administrator\Downloads\adusers.csv" -Header username,fullname,password,company,phone,city,department,dname
foreach ($user in $data){
       $name2=$user.username
       $adusername=Get-ADUser -Filter 'Name -eq $name2'  
         if (($adusername)){                    
                    Write-Host "User with name " $user.username " allredy exists" -ForegroundColor Green
                    Write-Host "Would you like to delete a user with name: " $user.username "?" -ForegroundColor Red
                        $yn=Read-Host "Enter some value: y/n "
                            switch($yn){
                                "y" {
                                    Remove-ADUser $user.username
                                    Write-Host "User with name " $user.username " - was removed" -ForegroundColor Red
                                    }

                                 default{
                                    Write-Host  "User with name " $user.username " stayed in the domain" -ForegroundColor Green

#--------------------------------------------------------------------------start------group validation code and adding user to group Active Directory--------------------------------------------------
                                     C:\Users\Administrator\Downloads\functionGetGroupAD.ps1
#==========================================================================stop-------group validation code and adding user to group Active Directory--------------------------------------------------
                                   }        
                            }            
                        }else{
                               $password=ConvertTo-SecureString $user.password -AsPlainText -Force
                                New-ADUser -Name $user.username -Surname $user.fullname -AccountPassword $password -PasswordNeverExpires $true -Company $user.company -OfficePhone $user.phone -City $user.city -Department $user.department -CannotChangePassword $true -Enabled $true
                                Set-ADUser $user.username -Enabled $true
                                Write-Host "User "$user.username" was added!" -ForegroundColor Green
                                       
#--------------------------------------------------------------------------start------group validation code and adding user to group Active Directory--------------------------------------------------
                                     C:\Users\Administrator\Downloads\functionGetGroupAD.ps1
#============================================================================stop-------group validation code and adding user to group Active Directory--------------------------------------------------
                }
            }