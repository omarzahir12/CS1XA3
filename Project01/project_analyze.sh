#!/bin/bash

echo "Hello $USER"
feat=0
while [ "$feat" -gt -1 ] ; do										# Runs an infinite loop which prompts the user for feature input
    echo -e "\nEnter a number corresponding to the following features:"
    echo -e "FIXME Log - 1\nFind Tag - 2\nFile Type Count - 3\nComment - 4\nCalculator - 5\nBackup and Delete / Restore - 6\nSwitch to Executable - 7\nExit - Any Key\n"
    read -p 'Feature No.: ' feat									# Prompts the user for a feature corresponding to the previous list
    if ! [[ "$feat" =~ ^[1-7]+$ ]] ; then								# Checks if the input is not one of the mentioned inputs
	echo -e "\nFeature not found\nProcess Terminating..."
	break
    #FIXME LOG
    elif [ "$feat" -eq '1' ] ; then
	if [ -e fixme.log ] ; then									# Checks if the file exists, and removes it if it does
            rm fixme.log
	fi
	touch fixme.log
	cd ..												# Moves to the CS1XA3 directory
        for file in $(grep -rl '#FIXME') ; do								# Searches for all files that contain #FIXME
	    lastline="$(tail -1 $file)"									# Checks to see if the last line of each of those files has the #FIXME
	    if [[ "$lastline" =~ "#FIXME" ]] ; then
                echo "$file" >> Project01/fixme.log							# Echo's file name into the log file
	    fi
	done
	cd Project01											# cd back into the Project01 directory to prepare for next iteration of loop
    #FIND TAG
    elif [ "$feat" -eq '2' ] ; then
        read -p 'Enter a valid search tag: ' searchTag							# Prompts User for a tag they want to search for
	if [[ "$searchTag" =~ '/' ]] ; then echo Input symbol not supported				# Gives an error for the / input
	else
	    if [ -e "$searchTag.log" ] ; then
	        rm "$searchTag.log"
	    fi
	    touch "$searchTag.log"
	    cd ..
	    tagLine="$(find . -type f -name "*.py" | xargs grep -h "#*$searchTag")"			# Searches for files ending in .py, and echo's all the lines in those files that meet the specifications
	    echo "$tagLine" >> Project01/"$searchTag.log"
	    cd Project01
	fi
    #FILE TYPE COUNT
    elif [ "$feat" -eq '3' ] ; then
	read -p 'Enter a valid file extension: ' exten
	cd ..
	fileCount="$(find . -type f -name "*$exten" | wc -l)"						# Searches for all files with the given extension and prints the amount of files with that extension
	echo "$fileCount"
	cd Project01
    #COMMENT Feature
    elif [ "$feat" -eq '4' ] ; then
	read -p 'Would you like to remove or identify comments? | Remove - 1 | Identify - 2 |: ' feat	# Prompts user for the command theu would like to do
	if ! [[ "$feat" =~ ^[1-2]+$ ]] ; then
            echo -e "\nFeature not found\nProcess Terminating..."
            break
	#Remove
	elif [ "$feat" -eq '1' ] ; then
	    read -p "Enter a file name: (If the file is in a directory, specify file path from the CS1XA3 directory): " file
	    cd ..
	    if [ -e "$file" ] ; then
	    	if [ -e "$file#.log" ] ; then								# Creates a comment file for the prompted file that stores all the coments
		    rm "$file#.log"
		fi
		touch "$file#.log"
		touch Project01/temp.log
		grep "^ *#" "$file" > "$file#.log"							# Puts all the comments from the original file in the comment file
		grep -v "^ *#" "$file" > Project01/temp.log; mv Project01/temp.log "$file"		# With a temp folder, the original file is stripped of all the comments and moved back as normal
	    else
		echo "File not found, try again"
	    cd Project01
	    fi
	#Identify
	elif [ "$feat" -eq '2' ] ; then
	    cd ..
	    if [ -e Project01/No#.log ] ; then
		rm Project01/No#.log
	    fi
	    touch Project01/No#.log
	    find . -type f -name "*" -not -path "./.git/*" | xargs grep -rlL "^ *#" > Project01/No#.log	# Checks for all the files that do not contain comments and puts them in a new file
	    cd Project01
	fi
    #Calculator Feature
    elif [ "$feat" -eq '5' ] ; then
	read -p "Would you like to preform a calculation in bash or python? | Bash - 1 | Python - 2 |: " feat
	if ! [[ "$feat" =~ ^[1-2]+$ ]] ; then
            echo -e "\nFeature not found\nProcess Terminating..."
            break
	fi
	if ! [[ -e operations.log ]] ; then
                touch operations.log
        fi
        read -p "Enter three arguments in the order; num, operation, num: " num1 oper num2		# Prompts user for basic calculation parameters
        operations=(+ - * / ^ %)									# Stores all the valid functions that can be executed
        if ! [[ "$num1" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] ; then
            echo ""$num1" is not a valid input"
	elif ! (printf '%s\n' "${operations[@]}" | grep -xq "$oper") ; then                             # Check if the operation is in the list
            echo ""$oper" is not a valid operation"
        elif ! [[ "$num2" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] ; then						# Checks if the number is actually a number
            echo ""$num2" is not a valid input"
	#Bash
	elif [ "$feat" -eq '1' ] ; then
            ans=$(echo "$num1$oper$num2" | bc)								# Performs calculation
            echo "$ans"
            echo "$num1$oper$num2=$ans	(Bash)" >> operations.log					# Writes an equation and prints into the log file
	#Python
	elif [ "$feat" -eq '2' ] ; then
	    echo hello
	    if [ -e operations.py ] ; then								# Removes a python file if it exists
		rm operations.py
	    fi
	    touch operations.py										# Creates the python file to perform calculations on
	    echo '#! /usr/bin/env python' >> operations.py						# Puts the required things into the python file to execute
	    echo "print($num1$oper$num2)" >> operations.py						# Command in python
	    ans=$(python operations.py)
	    echo "$ans"
	    echo "$num1$oper$num2=$ans	(Python)" >> operations.log					# Prints the equation and answer into the log file
	fi
    #Backup and Delete/Restore
    elif [ "$feat" -eq '6' ] ; then
	read -p "Would you like to Backup or Restore? | Backup - 1 | Restore -2 |: " feat
	if ! [[ "$feat" =~ ^[1-2]+$ ]] ; then
            echo -e "\nFeature not found\nProcess Terminating..."
            break
	elif [ "$feat" -eq '1' ] ; then
	    if [ -d backup ] ; then									# Checks to see if the backup exists and removes it if it does and creates it again
		rm -r backup
	    fi
	    mkdir backup
	    touch backup/restore.log									# Creates the restore log file
	    cd ..
	    find . -type f -name "*.tmp" -print0 | while read -d $'\0' file					# Finds all tmp files and prints them in the restore log file
	    do
		echo "$file" >> Project01/backup/restore.log
		mv "$file" Project01/backup								# Moves the files from their original into the backup directory
	    done
	    cd Project01
	elif [ "$feat" -eq '2' ] ; then
	    if [ -d backup ] && [ -e backup/restore.log ] ; then 					# Only if the backup directory and restore files exist
		cd ..
		while read filepath									# For each line in the restore file, which is a line
		do 
		    file="$(basename $filepath)"							# Remove the path from the name so you can use it to move just the file to a new location
		    mv Project01/backup/"$file" "$filepath"
		done < Project01/backup/restore.log
		cd Project01
		rm backup/restore.log
	    else
		echo "File Permissions.log Does Not Exist"
	    fi
	fi
    # Switch to Executable
    elif [ "$feat" -eq '7' ] ; then
	cd ..
	if [ -e Project01/permissions.log ] ; then 
	    rm Project01/permissions.log
	touch Project01/permissions.log
	fi
	read -p "Would you like to Change or Restore? | Change - 1 | Restore - 2 |: " feat
	if ! [[ "$feat" =~ ^[1-2]+$ ]] ; then
            echo -e "\nFeature not found\nProcess Terminating..."
            break
	fi
	if [ "$feat" -eq 1 ] ; then
	    find . -type f -name "*.sh" -print0 | while read -d $'\0' file				# For each file that the find command finds, it will do the following 
            do
		per="$(stat -c %a "$file")"								# Stores the number format of the execution code in a variable
		echo ""$file":"$per"" >> Project01/permissions.log					# Stores the file information to be referred to later
		u="$(echo "$per" | cut -c1)"								# Stores the user, group, and others permisssions seperately
		g="$(echo "$per" | cut -c2)"
		o="$(echo "$per" | cut -c3)"
		if [ "$u" -eq '6' ] ; then								# Case when only read and write, not executable
		    u='7'
		elif [ "$u" -eq '2' ] ; then								# Case when only write and not executable
                    u='3'
		elif [ "$u" -eq '5' ] ; then								# Case when read and executable, not write
		    u='4'
		elif [ "$u" -eq '1' ] ; then								# Case when only executable, not write
		    u='0'
		fi
		if [ "$g" -eq '6' ] ; then
                    g='7'
		elif [ "$g" -eq '2' ] ; then
                    g='3'
		elif [ "$g" -eq '5' ] ; then
                    g='4'
                elif [ "$g" -eq '1' ] ; then
                    g='0'
		fi
		if [ "$o" -eq '6' ] ; then
                    o='7'
		elif [ "$o" -eq '2' ] ; then
                    o='3'
		elif [ "$o" -eq '5' ] ; then
                    o='4'
                elif [ "$o" -eq '1' ] ; then
                    o='0'
		fi
		chmod "$u$g$o" "$file"
	    done
	elif [ "$feat" -eq 2 ] ; then
	    if [ -e Project01/permissions.log ] ; then
                while read filepermissions
                do
		    file="$(echo "$filepermissions" | cut -f1 -d:)"					# Takes the file part from the line in permissions
		    per="$(echo "$filepermissions" | cut -f2 -d:)"					# Takes the permission part of the line in permissions
		    if [ -e "$file" ] ; then								# Only when the file actually exists will it change it
		        chmod "$per" "$file"
		    fi
	        done < Project01/permissions.log							# Reads from the permissions file in Project01
	    else
		echo "File Permissions.log does not exist"
	    fi
	fi
	cd Project01
    fi
done
echo -e "\nProgram Execution Complete"
