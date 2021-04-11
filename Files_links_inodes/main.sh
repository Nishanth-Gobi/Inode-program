#!/bin/bash


#make sure to not comment it the second time u run
#also have two text files[1&3] created with some content

#rm file2.txt
#rm file4.txt
#rm list_files.txt                        
#rm direc1				   
#rm file6.txt
#rm file7.txt
#rm symlink

main()
{
	# Finding the inode number of file1 
	
	echo -e "\n-----------------------------------------------------------------------------------------------"
	echo -e "-----------------------------------------------------------------------------------------------"
	
	inode_1=`ls -li file1.txt`

	echo -n -e '\n INODE NUMBER OF FILE 1 : '
	echo `ls -li file1.txt | cut -d ' ' -f 1` 
 
	# creating a hard link between file1 and file2

	ln file1.txt file2.txt 

	# checking if the inode number of file1 equal to file2

	inode_2=`ls -li file1.txt | cut -d ' ' -f 1`
	inode_3=`ls -li file2.txt | cut -d ' ' -f 1`

	if [ $inode_2 == $inode_3 ]
	then
		echo -e "INODE NUMBER OF FILE1 = INODE NUMBER OF FILE 2 [ie:of the hardlink and source file]\n"
	else
		echo -e "INODE NUMBER OF FILE 1 != INODE NUMEBR OF FILE 2[ ie:of the hardlink and source file]\n"	
	fi

	# checking if the contents of the file1 and file2 are the same

	cmp --silent file1.txt file2.txt && echo "CONTENTS OF HARDLINK AND SOURCE FILE ARE SAME"|| echo "CONTENTS OF HARDLINK AND SOURCE FILE ARE DIFFERENT"

	
	#edit the contents of file2 [hardlink]

	sudo nano file2.txt
	echo -e "SUCCESSFULLY EDITED THE CONTENTS OF FILE2.TXT [hardlink]"
	# now check if the file contents are same or not

	cmp --silent file1.txt file2.txt && echo -e "\nCONTENTS OF THE FILES ARE ALIKE   "|| echo -e "\nCONTENTS OF THE FILES ARE DIFFERENT"

	# remove file1
	echo -e "\n REMOVING FILE1 [source file]"
	rm file1.txt

	# checking if file2 still exists and also note if it is empty or not
	#test -f file2.txt && echo "file2 exist"|| echo "file2 doesnot exist"

	if ls | grep -q "file2.txt"
	then
		echo -n "FILE 2 [hardlink] EXISTS AND"
		if [ -s file2.txt ]
		then
			echo " HAS SOME CONETENT"
		else
			echo " IS EMPTY"
		fi
	else
		echo -e  "FILE 2 [hardlink] DOES NOT EXIST\n"
	fi

	echo -e "\n----------------------------------------------------------------------------------------------------------"
	echo -e "\n----------------------------------------------------------------------------------------------------------"
	#Lets see what happens by deleting the links and see the diiference

		echo -e "CREATING A TEXT FILE NAMED file1.txt\n"
		echo -e "WRITE SOME CONTENTS TO IT"
		cat > file1.txt

	#create hardlink to file1.txt

	ln file1.txt file6.txt

	#edit contents of file6.txt

	sudo nano file1.txt
	echo -e "\nSUCCESSFULLY EDITED THE CONTENTS OF SOURCE FILE"

	#now compare the contents of file1 anf file6

	cmp --silent file1.txt file6.txt && echo -e "\nCONTENTS OF HARDLINK IS SAME AS SOURCE FILE" || echo -e "CONTENTS OF HARDLINK IS DIFFERENT AS SOURCE FILE\n"

	#delete the hard linmk
	echo -e "\nREMOVING THE HARDLINK"
	unlink file6.txt

	#checking if file1  exist
	if ls | grep -q "file1.txt"
	then
		echo -n " FILE1[source file] STILL EXIST AND"
		if [ -s file1.txt ]
		then
			echo " HAS SOME CONTENT"
		else
			echo " IS EMPTY"
		fi
	else
		echo -e "FILE1 DOESNOT EXIST\n"
	fi

	echo -e "\n------------------------------------------------------------------------------------------"
	echo -e "------------------------------------------------------------------------------------------"
	#strace command traces the execution of system calls as the command rm file2.txt is run
	strace rm file2.txt

	echo -e "\n------------------------------------------------------------------------------------------"
        echo -e "------------------------------------------------------------------------------------------"

	#create softlink to file3

	ln -s file3.txt file4.txt

	#checking if inode numbers of file3 and file4 are same

	ls -li file*.txt > list_files.txt

	inode_4=`head -n 1 list_files.txt | cut -d ' ' -f 1`
	inode_5=`tail -n 1 list_files.txt | cut -d ' ' -f 1`

	if [ $inode_4 == $inode_5 ]
	then
		echo -e "INODE NUMBER OF FILE3 [sourcefile] = INODE NUMBER OF FILE4 [softlink]\n"
	else
		echo -e "INODE NUMBER OF FILE3 [sourcefile] != INODE NUMBER OF FILE4 [softlink]\n"
	fi

	#cheching if the contents of file3 and file4 are the same

	cmp --silent file3.txt file4.txt && echo -e "\nCONTENTS OF BOTH SOURCE FILE AND SOFT LINK ARE SAME\n" || echo -e "\nCONTENTS OF BOTH SOURCE FILE AND SOFT LINK ARE DIFFERENT"

	#editing file4 content

	sudo nano file4.txt
	echo -e "SUCCESSFULLY EDITED THE CONTENTS OF SOFTLINK\n"

	#now compare the files 3 and 4

	cmp --silent file3.txt file4.txt && echo -e "\nCONTENTS OF THE FILE IS SAME AS SOURCE FILE AFTER EDITING AS WELL" || echo -e "\nCONTENTS OF SOURCE FILE AND SOFTLINK ARE DIFFERENT AFTER EDITING"

	#deleting file3

	unlink file3.txt
	echo -e "DELETED file3.txt [SOURCE FILE]\n"
	#checking if file4 exist and also note if its empty or not

	if ls | grep -q "file4.txt"
	then
		echo -n "FILE 4 [softlink] EXIST AND"
		if [ -s file4.txt ]
		then
			echo " HAS SOME CONTENT"
		else
			echo -e " IS EMPTY , ********points to a non existent file********\n"
		fi
	else
		echo -e "File 4 DOESNOT EXIST\n"
	fi

	echo -e "\n------------------------------------------------------------------------------------------------"
	echo -e "\n------------------------------------------------------------------------------------------------"

	#create soft link to file1.txt
	ln -s file1.txt file7.txt

	#edit contents of file7.txt

	sudo nano file1.txt
	echo -e "SUCCESSFULLY EDITED THE CONTENTS OF SOURCEFILE\n"

	#now compare the contents of file1 and file7

	cmp --silent file1.txt file7.txt && echo -e "\nFILES CONTENTS [source file and softlink] ARE SAME" || echo "FILES CONTENTS ARE DIFFERENT"

	#delete the soft link
 
	unlink  file7.txt
	echo  -e "DELETD SOFT LINK\n"

	#checking if file1 exist
	if ls | grep -q "file1.txt"
	then
		echo -n "FILE 1 [source file] EXIST AND"
		if [ -s file1.txt ]
		then 
			echo " HAS SOME CONTENT"
		else
			echo " IS EMPTY "
		fi
	else
		echo -e "FILE 1 DOES NOT EXIST\n"
	fi

	echo -e "\n---------------------------------------------------------------------------------------------------------------"
	echo -e "\n---------------------------------------------------------------------------------------------------------------"

	#analysation  with directories

	#create harlink for a directory
	echo -e "CREATING A DIRECTORY NAME direc1\n"
	mkdir direc1
	echo -e "DIRECTORY CREATED \n"
	ln direc1 hardlink

	#create symlink for a folder/directory
	echo -e "CREATING SOFT LINK TO THE HOME DIRECTORY\n"
	ln -s /home/aarthi symlink

	#inode number of directory is
	echo `ls -lid direc1`

	#check if inodes are same
	inode_1=`ls -lid /home/aarthi | cut -d ' ' -f 1`                   #*****************MODIFY/ADD IN YOUR DIRECTORY NAME*******************
	inode_2=`ls -li symlink | cut -d ' ' -f 1`

	if [ $inode_1 == $inode_2 ]
	then
		echo -e "INODE NUMBERS OF DIRECTORY AND SYMLINK ARE SAME\n"
	else
		echo -e "INODE NUMBERS OF DIRECTORY AND SYMLINK ARE DIFFERENT\n"
	fi
	#contents in symlink
	echo -e "CONTENTS IN SYMLINK \n"
	cd symlink | ls
	echo "---------------same as home directory-------------"
}

main
