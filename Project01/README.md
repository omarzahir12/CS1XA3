# CS1XA3 Project01 - ZAHIRM1

## Usage

Execute this script from project root with:

`chmod +x CS1XA3/Project01/project_analyze.sh`
`cd CS1XA3/Project01`
`./project_analyze.sh`

Once that is done, the file will issue a greeting, followed by a list of possible and valid features, each with their corresponding number value that will be prompted to execute the command.

The list of commands and their values are as follows:
* FIXME Log - 1
* File Size List - 2
* File Type Count - 3
* Exit - Any Key

## Feature 1 - Script Input

### Description

This feature is used to prompt the user for input and allows them to access the other features.
The feature can be terminated by inputing any input other than those listed. The completion 
of a feature will lead to the reexecution of this feature, until you enterthe exit command. If 
this feature does not work as expected, CTRL+C may resolve the issue.

The feature runs what is essentially an infinite loop, containing if statements for each feature by matching comparing for the feature prompt in the menu. There is a break for any input other than the ones stated so the code is terminated.

### Execution

This feature is executed by default when the script `project_analyze.sh` is executed.

### References
Inspiration was taken from:
[Obtaining input on the same line](https://stackoverflow.com/questions/9720168/shell-script-read-on-same-line-after-echoing-a-message)
[Accounting for non-integer inputs](https://unix.stackexchange.com/questions/151654/checking-if-an-input-number-is-an-integer)

## Feature 2 - FIXME Log

### Description

This feature searches your repo for all files that have `#FIXME` on the last line of their
code, and creates, or overwrites if it exists, a file `fixme.log` in the `Project01` directory
that stores the name of all these files.

The feature implements a for loop for all files in the repo that have `#FIXME` and checks if their last line matches `#FIXME`, and then echo's their file names into the log file.

### Execution

This feature can be executed by entering `1` when prompted to do so. The command list will also
remind you of this.

### References
Inspiration was taken from:
[Bash For Loops](https://linuxize.com/post/bash-for-loop/)
[How to get last line from a file with grep](https://stackoverflow.com/questions/14885554/get-last-line-from-grep-search-on-multiple-files)

## Feature 3 - Find Tag

### Description
This feature prompts the user for a file tag, and returns only those lines of all the `.py`
files in your repo containing the `#` and tag anywhere on that same line.

This feature implements the find feature for `.py` files and the grep feature to locate the lines with the search tag.

### Execution
This feature can be executed by entering `2` when prompted to do so. The command list will also
remind you of this.

### References
Inspiration was taken from:
[How to use the xargs command](https://javarevisited.blogspot.com/2012/06/10-xargs-command-example-in-linux-unix.html)

## Feature 4 - File Type Count

### Description

This feature prompts the user for a file extension, and prints out the number offiles in your
repo that end with the given file extension.

This feature searches for all files with the given extension using the `find` command, and 
pipes it into the `wc -l` command.

### Pitfalls

This feature returns a warning if `/` is input as a file extension

### Execution

This feature can be executed by entering `3` when prompted to do so. The command list will also
remind you of this.

### References
Inspiration was taken from:
[Using the find command in linux](https://www.linode.com/docs/tools-reference/tools/find-files-in-linux-using-the-command-line/)

# Proposed Custom Features
### Custom Feature 1 - Comment Files
This feature will consist of two tasks, and prompt the user for whichever of the two tasks they would like to complete. The user will be prompted for either `remove` or `identify`
* If `remove` is chosen, prompt the user for a file and remove all the comments from the file and place them in an accompanying log comment file.
* If `identify` is chosen, identify all the files in your repo that do not have comments and put them in a log file for reference.

**Note: An important assumption will be that the comments will be the only thing in that line**

Example:
`Code` #This is not a comment

#This is a comment
`Code`

### Custom Feature 2 - Arithmetic Calculator
This feature will consist of the same task and result, however, the implementation will be done in two seperate ways, one using bash bult in operations, and the other using a python file. The 
* The user will first be prompted to enter the method in which they would like the command done, entering `bash` for bash, and `python` for python 
* The user will be prompted to input a basic arithmetic operator, (+,-,*,/, etc.), along with two numbers. The program will then return the result of the operation, as well as storing the operation with the result in an accompanying log file.

## Feature 5 - COMMENT Feature (Custom #1)

### Description
This feature will consist of two tasks, and prompt the user for whichever of the two tasks they would like to complete. The user will be prompted for either `remove` or `identify`
* If `remove` is chosen, prompt the user for a file and remove all the comments from the file and place them in an accompanying log comment file.
* If `identify` is chosen, identify all the files in your repo that do not have comments and put them in a log file for reference.

**Note: An important assumption will be that the comments will be the only thing in that line**

Example:
`Code` #This is not a comment

#This is a comment
`Code`

For its first part, this feature uses grep to identify lines without comments and creates a file withoutas well as a file with$
identifies, using grep, all the files that do not contain comments and prints them out for the user to see.

### Execution

This feature can be executed by entering `4` when prompted to do so. The command list will also
remind you of this.

## Feature 6 - Calculator Feature (Custom #2)

### Description
This feature will consist of the same task and result, however, the implementation will be done in two seperate ways, one using bash built-in operations, and the other using a python file. 
* The user will first be prompted to enter the method in which they would like the command done, entering `bash` for bash, and `python` for python 
* The user will be prompted to input a basic arithmetic operator, (+,-,*,/, etc.), along with two numbers. The program will then return the result of the operation, as well as storing the operation with the result in an accompanying log file.

For the first part, the inputs are taken and cast to the built in built in basic calculator in bash. For the second part, a python file is created simply to cast the operation and the output is received after
the python file is run.

### Execution

This feature can be executed by entering `5` when prompted to do so. The command list will also
remind you of this.

### References
[How to use the basic calculator in bash](https://www.tutorialsandyou.com/bash-shell-scripting/bash-bc-18.html)
[Checking whether an item is in an array](https://unix.stackexchange.com/questions/177138/how-do-i-test-if-an-item-is-in-a-bash-array)

## Feature 7 - Backup and Delete / Restore
### Description
Using the read command, prompt the user to Backup or Restore (use a prompt that tells the user
what to do)
If the user selects Backup:
* Create an empty directory `CS1XA3/Project01/backup` if it doesnt exit
* Empty the directory `CS1XA3/Project01/backup` if it does exist
* Find all files that end in the .tmp extension
 copy them to the `CS1XA3/Project01/backup` directory
 delete them from their original location
 create a file `CS1XA3/Project01/backup/restore.log` that contains a list of paths of the
files original locations

If the user selects Restore:
* Use the file `CS1XA3/Project01/backup/restore.log` to restore the files to their original location
* If the file does not exist, through an error message

For the first part, find is used to identify all `.tmp` files and they are moved from the current location and moved to the backup directory, while the file path is sent to the restore.log
For part two, the lines in the code are extracted for their file and file paths seperately, and then moved out of the backup directory accordingly.

### Execution

This feature can be executed by entering `6` when prompted to do so. The command list will also
remind you of this.

### Pitfall

If the files have the same name but are in different directories, only one is backed up

### References
[How to use the basename command in bash](https://stackoverflow.com/questions/9011233/for-files-in-directory-only-echo-filename-no-path)
[Recursing through a file line by line](https://www.shellhacks.com/bash-read-file-line-by-line-while-read-line-loop/)

## Feature 8 - Switch to Executable
### Description
Find all shell scripts (i.e ending in .sh) in the repo
* Create a file `CS1XA3/Project01/permissions.log` if it doesnt already exist
* Using the read command, prompt the user to Change or Restore (use a prompt that tells the user
what to do)
* If the user selects Change:
 For each shell script, change the permissions so that only people who have write permissions
also have executable permissions (i.e if only user has write permissions, then only user has
executable permissions)
 Store a log of the file and its original permissions in `CS1XA3/Project01/permissions.log`
(overwrite it if it already exists)
* If the user selects Restore
 Restore each file to its original permissions (as specified in `CS1XA3/Project01/permissions.log`)

Using the `stat -c %a` command, I extract the three digit number corresponding to the permissions for each user and extract them seperately and have a case corresponding to each possibility.
The name of the file and its three digit number are also stored. For part 2, the file path and the permissions are extracted seperately using the cut command and changes the permissions accordingly.

### Execution

This feature can be executed by entering `7` when prompted to do so. The command list will also
remind you of this.

### References
[Extracting specific parts of a string](https://stackoverflow.com/questions/10520623/how-to-split-one-string-into-multiple-variables-in-bash-shell)
[Obtaining the permission bits for a file](https://unix.stackexchange.com/questions/97644/how-to-inspect-group-permissions-of-a-file)
