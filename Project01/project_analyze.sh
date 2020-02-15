#!/bin/bash

echo "Hello $USER"
feat=0
while [ "$feat" -gt -1 ] ; do										# Runs an infinite loop which prompts the user for feature input
    echo -e "\nEnter a number corresponding to the following features:"
    echo -e "FIXME Log - 1\nFind Tag - 2\nFile Type Count - 3\nExit - Any Key\n"
    read -p 'Feature No.: ' feat									# Prompts the user for a feature corresponding to the previous list
    if ! [[ "$feat" =~ ^[1-3]+$ ]] ; then								# Checks if the input is not one of the mentioned inputs
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
        read -p 'Enter a valid search tag:' searchTag							# Prompts User for a tag they want to search for
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
    echo -e "\nFeature Complete"
    fi
done
echo -e "\nProgram Execution Complete"
