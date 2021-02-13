#!/bin/bash
clear
if [ $# == 0 ]
 then
  echo " No option is slected please use one of these options : 
-Insert new contact name and number if same name are enterted the contact will update and new number will be added., wit the option \"-i\"
-View all saved contacts details, with the option \"-v\"
-Search by contact name, with the optionn \"-s\"
-Delete all records, with \"-e\"
-Delete only one contact name, with \"-d\"
-For help and Examples, with \"--help\""
else
case $1 in 
  -i)
    # if [[ $2  =~ ^[a-zA-Z\s-]+$ ]]
     #   then 
	   if [[ $3 =~ ^[0-9]+$ ]]
	     then 
		grep -q -E "Name:$2\sPhone:[0-9]+" ./phonebook.sh
       		 if [ $? != 0 ]
        	  then
			echo "Name:$2 Phone:$3" >> ./phonebook.sh
	               echo "Contact added Successfully"

        	else
        		temp="$(grep -E "Name:$2\sPhone:[0-9]+" ./phonebook.sh),$3"
			sed -i -E "/Name:$2\sPhone:[0-9]+/d" ./phonebook.sh
			echo "$temp" >> ./phonebook.sh
        		 echo "Conatct updated successfully  "
        	fi

	  else 
	      echo "Inaviled Number, Please enter name and number between ''" 
           fi;;
    # else 
    #    echo "Invailed Name, Please enter name and number between ''"
    # fi;;
   -v)
      echo "ALL Contacts in the PhoneBook : "
	grep -E "Name:.*\sPhone:[0-9]+" ./phonebook.sh;;
   -d)
	# if [[ $2  =~ ^[a-zA-Z\s-]+$ ]]
       #then
	grep -q -E "Name:$2\sPhone:[0-9]+" ./phonebook.sh 
        if [ $? != 0 ]  
	then
            echo "Contact Not found :("
	else
	sed -i -E "/Name:$2\sPhone:[0-9]+/d" ./phonebook.sh 
	 echo "Conatct deleted Successfully "
        fi;;
    # else
    #    echo "Invailed Name input"
    # fi;;

   -s)
     # if [[ $2  =~ ^[a-zA-Z\s-]+$ ]]
      # then 
	grep -E "Name:.*$2.*\sPhone:[0-9]+" ./phonebook.sh
	if [ $? != 0 ]
          then
	    echo "Contact Not found :("
	fi ;;
     # else
     #   echo "Invailed Name input"
     #fi;;

   -e)
	sed -i -E "/Name:.*\sPhone:[0-9]+/d" ./phonebook.sh
	echo "ALL contacts Deleted successfully :) ";;
   --help)
	echo "Usage: phonebook.sh [OPITIONS] 'Name' 'Phone Number'

This a phonebook to store contacts (names and phones). 
Phonebook database are stored in the same file of the script to make it portable.

Options are :
  -i, Insert a new contact, if same name are enterted the contact will update and new number will be added. 
  -v, View all the saved contacts.
  -s, Search for an contact it is smart that it brings all contacts has enterted name.
  -e, Delete all the contacts.
  -d, Delete a specific contact by name.

Example: bash phonebook.sh -i 'andrew Ezzat' '0100307058' ";;		
   *)
     echo "Invaild option" ;;
esac
fi 
exit 0 
