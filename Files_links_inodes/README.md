# Inodes & Files

### Program description

<strong>Source</strong>: Operating System concepts (9th edition) by Abraham Silberschatz, Peter B.Galvin and Greg Gagne [Page-no: 535 Excercise: 11.13]

#### The following exercise examines the relationship between files and inodes on a UNIX or Linux system. 

 -> Open a file/directory and examine its contents. Next, obtain the inode number of this file
 
 -> Create links between a source and target files. 

UNIX provides two types of links: (1) hard links and (2) soft links.
 -> create hardlink/softlink !Are the inodes same or different? Do the two files have the same or different contents?
 ->Next, edit source file and change its contents. similar way edit for hardlink and examine fully 

 ->remove the source file/links and see for existence of either of them
 -> you can trace the execution if system calls and see

