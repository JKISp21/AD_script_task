#--------------------------------------------------------------------------start------group validation code and adding user to group Active Directory--------------------------------------------------
                         # function GetGroupAD  {}
                                Write-Host "Would you like to add user" $user.username "to a grupp named" $user.department " ?" -ForegroundColor Red
                                    $yn=Read-Host "Enter some value: y/n "
                                    switch($yn){
                                        "y" {                                                                      
                                   $gruppname=$user.department
                                   $adgruppname=Get-ADGroup -filter 'SamAccountName -eq $gruppname'

                                     if (($adgruppname)){
                    
                                                Write-Host "Grupp with name " $gruppname " allredy exists_01" -ForegroundColor Green
                                                Add-ADGroupMember -Identity $gruppname -Members $name2
                                                Write-Host "User with name " $user.username " nas been added to an existing group" $gruppname -ForegroundColor Green

                                            }else{
                                               Write-Host "Grupp with name " $gruppname " not created" -ForegroundColor Red
                                               Write-Host "Would you like to create a grupp with name: " $gruppname "?" -ForegroundColor Red
                  
                                              $yn=Read-Host "Enter some value: y/n "
                                                switch($yn){
                                                    "y" {
                                                         New-ADGroup -GroupScope Domainlocal -Name $gruppname
                                                         Write-Host "Grupp with name " $gruppname " was created" -ForegroundColor Green
                                                         Add-ADGroupMember -Identity '$gruppname' -Members '$user.username'
                                                         Write-Host "User with name " $user.username " nas been added into the newly created group" $gruppname -ForegroundColor Green
                                                        }

                                                     default{
                                                        Write-Host "Grupp with name " $gruppname " not created" -ForegroundColor Red
                                                        Write-Host "User with name " $user.username " user was not added to the group" $gruppname "due to its asence" -ForegroundColor Green
                                                       }        
                                                     }                  
                                                  }
                                           }
                                    default{
                                            Write-Host "User with name " $user.username " user was not added to the group" $gruppname -ForegroundColor Red
                                            }
                            }
                            
#==========================================================================stop-------group validation code and adding user to group Active Directory--------------------------------------------------