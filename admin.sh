#!/bin/bash



####Task input to create user and groups ###########
###

echo "Enter To Print the menu again"
PS3="Enter The Option: ";export PS3

select x in user group close;
do
	case $x in
		user)
		        select y in useradd usermod userdel back;
                        do
                                echo "Your are in user menu"
                                case $y in
                                        useradd)
                                                read -p "Enter the name of user: " name
                                                useradd $name
                                                echo "You will make passwd for this user"
                                                passwd $name
                                                ;;
                                        usermod)
						select z in Sec-G-Add Sec-G-Del moveHomDir Lock unlock shell comment back;
						do
						case $z in 
							Sec-G-Add)
								read -p "Enter The name of user want to mod: " name
								read -p "Entername of Seconadry Group:  " Group
								usermod -aG $Group $name 
								id $name 
								;;
							Sec-G-Del) 
								read -p "Enter The name of user want to mod: " name
								read -p "Entername of Seconadry Group:  " Group
								gpasswd -d $name $Group
								id $name
								;;
							moveHomDir)
								read -p "Enter The name of User: " name
								read -p "Enter the new Location: " Loc
								usermod -m "$Loc" $name
							cat /etc/passwd | grep $name
								;;
							Lock)
								read -p "Enter The name of User: " name
								usermod -L $name
                                                                echo "User $name is Locked"
								;;
							unlock)
								read -p "Enter The name of User: " name
								usermod -U $name
								echo "User : $name is Unlocked "
								;;
							shell)
								read -p "Enter The name of User: " name
								read -p "Input Shell Type: " shell
								usermod -s $shell $name
								cat /etc/passwd | grep $name
								;;
							comment)
								read -p "Enter the User name: " name
								read -p "Enter the comment: " comment
								usermod -c $comment $name
								;;
							back)
								echo "back to the last menu "
								break
								;;
						esac
						done
                                                ;;
                                        userdel)
                                                echo "Warning you in delete mode"
						read -p "Input the name of user: " name
						read -p "input Y if you want delete home directory" option
						if [ $option = 'Y' ] || [ $option = 'y'];
						then
							userdel -r $name
						else
							userdel $name
						fi
						       	;;
                                        back)
						echo "You back one menu"
                                                break
                                                ;;
					*)
						echo "You Input unvalid Input"
						;;

                                esac

               		done
			;;
		group)
			select y in groupadd groupmod groupdel back;
			do
				case $y in 
					groupadd)
						read -p "Enter Groupname: " group
						groupadd $group
						;;
					groupmod)
						select x in addusers changename back;
						do
							case  $x in
								addusers)
									read -p "enter Group name: " group
									read -p "enter the user name: " name
									groupmod -aU $name $group 
									cat /etc/group | grep $group 
									;;
								changename)
									read -p "Enter group name: " group
									read -p "Enter the new group name: " newgroup
									groupmod -n $newgroup $group
									cat /etc/group | grep $newgroup
									;;
								back)
									echo "You back in menu "
									break
									;;
								*)
									echo "You Enter Invalid Input"
									;;
							esac		
						done
						;;
					groupdel)
						read -p "Enter name of group you want to delete: " group
						echo "Primary group is didnot delete"
						groupdel $group
						;;
					back)
						echo "You back in menu"
						break
						;;
				esac
			done
			;;
		close)
			break
			;;
		*)
			echo "invalid input"
			;;
	esac
done
