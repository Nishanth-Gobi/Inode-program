

#!/bin/sh

main_menu()
{
  while :
  do
    echo -e '\t 1) DISPLAY FILE DETAILS'
    echo -e '\t 2) DELETE A FILE'
    echo -e '\t 3) INODE DETAILS'
    echo -e '\t 4) EXIT '
    echo -e -n '\t ENTER YOUR CHOICE: '

    read resp
    case "$resp" in

    1) file_details;;
    2) file_delete;;
    3) inode_details;;
    4) exit 0;;
    *) printf "\n***RE-ENTER A VALID CHOICE: ";;

    esac
  done
}

file_details()
{
  clear
  echo ""
  read -p "ENTER FILE/DIRECTORY NAME: " filename
   
  echo -e "\n\n------------------------------------------------------------------------------------------------------------"
  # Terse is an IBM archieve file format that supports lossless compression
  echo -n -e "\nInfo in Terse form: " 
  stat -t $filename 
  echo -e "\n------------------------------------------------------------------------------------------------------------"
  echo -e "\n----------------------------------------------------------------------------------------------------"
  echo -e "\nGeneral File/Directory info: "
  echo -e "\n----------------------------------------------------------------------------------------------------"
  stat --printf="The File %n is %s bytes,and is a %F type file\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The inode number of this file is %i\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The number of hardlinks to the file is %h\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="Total number of blocks allocated is %b and size of each block is in bytes is %B\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="Device number is %d with major device type as %t and minor device type as %T\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The mount point is %m\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The birth time of file is %w and last access time was %x\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The file was recently modified on %y\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat --printf="The file user is %U and his/her id is %u\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  echo "----------------------------------------------------------------------------------------------------"
  echo -e "\nDetails of File system\n"
  echo "----------------------------------------------------------------------------------------------------"
  stat -f --printf="File system ID in hex is %i\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat -f --printf="The total data blocks in %T is %b\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat -f --printf="Among them free blocks is %f with %a free blocks available to non-superuser\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat -f --printf="Total filenodes in filesystem is %c\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  stat -f --printf="Among them number of free filenodes is %d\n" $filename
  echo "----------------------------------------------------------------------------------------------------"
  echo -e "----------------------------------------------------------------------------------------------------\n\n"
}

file_delete()
{
  read -p "ENTER FILE NAME: " file_name
  inode_num="$(stat $file_name | head -3 | tail -1 | awk '{print $4}')"
  # find / -type f -inum 8536263 -xdev > temp.txt
  # The above command stores all the files with matching inode number in the current file system in temp.txt
  # We can ask the user to choose one amonf the files and delte it
  # This gives the functionality to delete any file from any directory 

  find . -inum $inode_num -delete
}

inode_details()
{
  clear
  echo -e -n "\n\t\t***INODE DETAILS OF ALL FILESYSTEMS***\n"
  echo -e "------------------------------------------------------------------\n"   
  echo "$(df -ih)"
  echo -e "\n-----------------------------------------------------------------\n"
}

main_menu
