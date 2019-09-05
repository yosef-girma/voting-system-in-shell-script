function view_voter()
{

    clear
	printf "********************************* Voter  List***************************** \n";
    
    printf "ID  F Name  L Name    Email        address         voted      \n" ;


                echo "----------------------------------------------------------"
                cat user.txt 
                echo ""
                echo "----------------------------------------------------------"
                echo ""
                echo "    Press any key to return to Main Menu:  "
                read response
                voter_record ;
}


function delete_voter()
{
	   clear
	   printf "\n\n************************************** Delete Voter ****************************\n\n";
  
       printf  "Enter id of Voter to be  Delete: ";
      
       read delvoterid;


      
        echo "All data with the id $delvoterid will be deleted. Are you sure you want to do this?(Y/N)" 
        read confirmdel
          
        case "$confirmdel" in
                 "Y"|"y" ) 
                 cat user.txt|grep -v $delvoterid >temp.txt; cp temp.txt user.txt
                 printf "The record is sucessfully deleted";
                 ;;
                 "N"|"n" ) 
                 echo "\nPress any key to return to Main Menu"
                 read mainresponse ;
                voter_record ;;

                 * )
                  delete_voter


  esac

 printf "\n press any key to go back \n"
 read response;
 voter_record ;

}

function add_voter()
{
    clear
	registerUser "admin";
}



function voter_record()
{

clear

printf "\n\n \t ****************************************************** \n"
printf "\t\t    VOTER MENU \n"
printf "************************************************************** \n"

printf " 1.  ADD VOTER  \n";

printf " 2.  DELETE VOTER   \n";

printf " 3.  VIEW VOTER LIST \n"

printf "4.  BACK         \n"

read vochoice;

 case $vochoice in
 	1 )
       add_voter ;;
       
       2 )
delete_voter ;;
3 ) 

view_voter ;;

4 )
  admin_menu ;;
 * )
   
   printf "Invalid choice  please try again "
   voter_record ;;
 

  esac  


}

function delete_candidate()

{

	clear

	printf "\n\n************************************** Delete Candidate ****************************\n\n";
    
    printf "Enter ID of Candidate to be  Delete: ";

    read cid;
     


         echo "All data with the id $cid will be deleted. Are you sure you want to do this?(Y/N)" 
          read confirmdel
          
            case "$confirmdel" in
                 "Y"|"y" ) 
                 cat candidate.txt|grep -v $cid >temp.txt; cp temp.txt candidate.txt
                 printf "The record is sucessfully deleted";
                 ;;
                 "N"|"n" ) 
                 echo "\n Press any key to return to Main Menu"
                 read mainresponse ;
                 candidateRecord ;;

                 * )
                  delete_candidate


  esac

 printf "\n press any key to go back \n"
 read response;
 candidateRecord ;


}



function view_candidate()
{

local accounttype=$1;
clear
printf "*********************************Candidate  List***************************** \n";
printf "Candidate ID     Election Id    Name          gender          Description    Vote Count  \n" ;

 
echo "----------------------------------------------------------"
cat candidate.txt 
echo "      "
echo "----------------------------------------------------------"
echo ""
              
 printf "press any key to go back \n"
 read response;
 if [[ $accounttype == "user" ]];
 then
   usermenu ;
  else 	
 candidateRecord ;
 
 fi



}


function add_candidate()

{

     clear

    printf "\n\n \t ****************************************************** \n"
    printf "\t\t    Add Candidate Menu \n"
    printf "************************************************************** \n"

	    
   
        printf "Candidate Id: ";
        read candidateid;
        idprefix="can"
        candidateid="$idprefix$candidateid"
        printf "Election Id: ";
        read caneleid;
        printf "Candidate Name : ";
        read candiname;
        
        printf "Gender: ";
        read candgender;
        printf "Description"
        read canddescription
        // initialize candidiatevoter from 0 
        candidatevote=0;
        echo " $candidateid     $caneleid     $candiname        $candgender  $canddescription  $candididatevote" >>candidate.txt

        printf "Candidate $candiname  added to the record ";
        printf "press any key to go back \n"
        read gores;
        candidateRecord  ;

}


function candidateRecord()
{

clear

printf "\n\n \t ****************************************************** \n"
printf "\t\t    Candidate  Menu \n"
printf "************************************************************** \n"


printf "\t 1.  ADD CANDIDATE  \n" ;

printf "\t 2.  DELETE CANDIDATE   \n";

printf "\t 3.  VIEW CANDIDATE LIST \n";


printf "\t 4.  BACK         \n";

read candchoice;


 case $candchoice in
 	1 )=
       add_candidate ;;
    2 )
delete_candidate ;;
    3 )

    view_candidate ;;
    4 )
     
     admin_menu ;;
    * )
   
   printf "Invalid choice  please try again "
   candidateRecord ;;
 

  esac  



}

function delete_election()
{
	 clear

    printf "\n\n************************************** Delete Election ****************************\n\n" ;
    printf "Enter ID of Election to be  Delete: "
    read delelecid;

      
         echo "All data with the id $delelecid will be deleted. Are you sure you want to do this?(Y/N)" 
          read confirmdel
          
            case "$confirmdel" in
                 "Y"|"y" ) 
                 cat election.txt|grep -v $delelecid >temp.txt; cp temp.txt election.txt
                 printf "The record is sucessfully deleted";
                 ;;
                 "N"|"n" ) 
                 echo "Press any key to return to Main Menu"
                 read mainresponse ;
                 electinrecord ;;

                 * )
                  delete_election


  esac

    	           
   

    printf "press any key to go back"
    read  response;
    electinrecord ;


}

function election_result()
{
	view_candidate ;

}

function view_election()
{

clear

 local accounttype=$1;
 echo "accounttype type $accounttype"

printf "*********************************Election  List***************************** \n";

printf "ID     Topic    start date        end date             Description ";


echo "----------------------------------------------------------"
cat election.txt
echo ""
echo "----------------------------------------------------------"
               
               
if [[ $accounttype != "admin" ]]; then
	


printf "Do you want to proceed to vote ? Y/N  \n"
read  response;

if [[ $response == "Y" ]] || [[ $response == "y" ]]
   then
   	echo   -e "  please enter your id \c"
   	read voterid;
    printf "\n"

    echo -e " please enter the election id to vote for \c"
    read  eid;
  local eleid;
   local eleidfound=0;
 while read line; do
    for word in $line; do
        #echo "word = '$word'"
        if [[ $word == $eid ]]
        then
         eleidfound=1;
         
        fi

    done

 done < candidate.txt

  if [[ $eleidfound == 1 ]]
   then
printf "*********************************Candidate  List***************************** \n";
printf "ID     Election Id    Name       age   gender          Description      \n" ;

 
echo "----------------------------------------------------------"
         grep "$eid" -n candidate.txt
  fi

   else 
   	usermenu ;

fi






echo -e "please enter the candidate id to vote for \n"
read votecandidateid;

echo -e "Thank you !!! you voted for candidate with id  $votecandidateid "
 
 local candidiateline;
 local found=0;
 while read line; do
    for myword in $line; do
        #echo "word = '$word'"
        
        # this is equal make a flag that check the equality if they are equal assign line to 
        # other variable at the end of the loop we will get holder which hold the counter 
        # check the equality if they are equal break it 
        # take the line variable  
        if [[ $myword == $votecandidateid ]]
       then
        echo "This is $line"
        candidiateline=$line;   
        found=1; 
       fi
         holder=$myword;

    done
  # echo "outside $holder";

   
     if [[ $found == 1 ]]
     then
  
    break;
    
    fi
    



 done < candidate.txt

local newdata;

if [[ $found == 1 ]]; 
 then
      one=1;
      countvote=$(( holder + one ))
      echo $candidiateline;
      echo $countvote;
      
      for cword in $candidiateline ;
        do
   
   re='^[0-9]+$'
if ! [[ $cword =~ $re ]] ; then
   #echo "error: Not a number" >&2; exit 1
   newdata="$newdata                $cword"
else
	 newdata="$newdata              $countvote"
fi
 
 #   if ! [[ "$word" =~ ^[0-9]+$ ]]
  #  then
   #     echo "Sorry integers only"
             
      
    #   else
       
   # fi

    done 	

  # echo "success $newdata"
if [[ $found == 1 ]];
then
cat candidate.txt|grep -v $votecandidateid >tmp.txt;

echo $newdata >>tmp.txt
 cp tmp.txt candidate.txt 

fi


# echo "$icode         $iname                   $iqty                     $irty">> inv.txt   
 fi

 printf "press any key to go back"
 usermenu ;
 read response;

# end 
else
 
    printf "press any key to go back"
    read response;
	admin_menu ;
fi


}


function add_election()
{

   clear
	 
printf "\n\n------------------------------------------------------------ \n"
printf "\t\t    Election Add \n"

printf "---------------------------------------------------------------- \n"
        
        printf "Election Id 4  ";

        read elecid;  
        elecid="ele$elecid"
        printf "Election Topic: ";
        read electopic;
       
        printf "Start Date: ";
        read startdate;

        printf "End Date ";
        read enddate;
        printf "Description  ";
        read description;
        printf "Election Added To the Record ";
        
        echo "$elecid      $electopic    $startdate   $enddate   $description">> election.txt   
        printf "press any key to continue "
        read response;
        electinrecord ; 

}

function electinrecord()
{

clear

      printf "\n\n  \n"	
     
      echo -e " |         Election  MENU                 |\n"
	  echo -e " |-------------------------------------- | \n"
	  echo -e " |  1.  Election List                    | \n"
      echo -e " |  2.  Add New Election                 | \n"
	  echo -e " |  3.  Delete Election                  | \n"
	  echo -e " |  4.  Election Result                  | \n"
	  echo -e " |  5.  Back                             | \n"
      echo -e " |                                       | \n"
	  echo -e " |-------------------------------------- | \n"

      echo -e "\t Enter Your Choice. \c"

read  elecchoice;


 case $elecchoice in
 	1 )
       admintype="admin" ;

       view_election $admintype ;;
    2 )
       add_election ;;
    3 ) 
     delete_election ;;

   
    4 )
    
    election_result ;
    
    ;;
    5 )
    
     admin_menu 
    
    ;;
 * )
   
   printf "Invalid choice  please try again "
   electinrecord ;;
 

  esac  
}
function usermenu()
{

      clear	
      echo  "          USER MENU            \n"
	  echo	" |--------------------------------------|"
	  echo	" |  1.  Vote  & Election List           |"
      echo	" |  2.  Election Result                 |"
	  echo	" |                                      |"
	  echo	" |  3.  Logout                          |"
	  echo	" |  4.  Exit                            |"
      echo	" |                                      |"
	  echo	" |--------------------------------------|"

      echo "Enter Your Choice."
      read userchoice

  
 case $userchoice in
 	1 )
       #electinrecord ;;
       view_election  "user";;
    2 )
      view_candidate "user";;
    3 ) 
      
         printf "Are you sure you want to log out y/n"
         read logmeout;



   if [[ $logmeout == "y" ]] || [[ $logmeout == "Y" ]]
   	then
      
      useracc ;
     
   else 
        clear 
        usermenu ; 
     
   fi

        ;;
    4 )
   
   printf "\n Existing System in 3 second"
          sleep 3
          exit
 
     ;;
  

 * )
   
   printf "Invalid choice  please try again "
   voter_record ;;
 

  esac  

}

function userlogin()
{
     clear
	 printf "\n  **************************  LOGIN FORM  **************************  ";
     printf  " \n                       ENTER EMAIL:-";
	 read email;
	 printf  " \n                       ENTER PASSWORD:-";
     read password;

if grep -q $email user.txt; then
    if grep -q $password user.txt; then
    	 usermenu ;
    fi	   

else
   echo "please enter valid email and password press any key to continue"
   read res;
   userlogin ;
fi


    
   


}

function registerUser()
{
       //here you can confirms the ID

    local caller=$1;
    
    clear
 
    printf "\n\n \t ****************************************************** \n"
    printf "\t\t    Register New                                     \n"
    printf "************************************************************** \n"  
        echo -e  "Voter id  \c"
        read voterid;      
        echo -e  "First Name: \c" ;
        read firstname;
        printf "Last Name: " ;
        read lastname;
        printf "Enter your Email: ";
        read email;
        printf "Address: ";
        read address;
        printf "Enter your Password: ";
        read password;
       
        echo "$voterid   $firstname     $lastname    $email    $address     $password "  >> user.txt 

        printf "User Registered  sucessfully ";
     
       if [[ $caller == "admin" ]]; then 
       	voter_record ;
        else
        	useracc;

       fi



}

function useracc()
{


     
      clear	
      echo -e "\t\t         User Panel            "
	  echo -e "\t |--------------------------------------|"
	  echo -e "\t |  1.  Login                           |"
      echo -e "\t |  2.  Register new                    |"
	  echo -e "\t |  3.  Back                            |"
	  echo -e "\t |  4.  Exit                            |"
	  echo -e "\t |                                      |"
      echo -e "\t |                                      |"
	  echo -e "\t |--------------------------------------|"

      echo "Enter Your Choice."
      read userchoice;

     case $userchoice in
     	1 )
       
        userlogin ;;
         
         2 )

         registerUser 
         printf "press any key to go back \n"
         read response;
         useracc ;
        
        ;;
        
         3 )
          choose_account ;;
         4 )
          printf "\n Existing System in 3 second"
          sleep 3
          exit
          ;;
        * )
        printf "invalid choice try again"
        useracc ;
    esac

}

function admin_menu()
{

 
      clear	
      echo -e "\t\t         ADMIN MAIN MENU            "
	  echo -e "\t |--------------------------------------|"
	  echo -e "\t |  1.  Election Record                 |"
      echo -e "\t |  2.  Candidate Record                |"
	  echo -e "\t |  3.  Voter Record                    |"
	  echo -e "\t |  4.  Logout                          |"
	  echo -e "\t |  5.  Exit                             |"
      echo -e "\t |                                      |"
	  echo -e "\t |--------------------------------------|"

      echo "Enter Your Choice."
      read adminchoice;

  
  case $adminchoice in 

  	1 )
      electinrecord ;
     ;;

     2 )
    candidateRecord ;
    ;;

    3 )
 
   voter_record ;
   ;;
   4 )

     choose_account ;
   ;;

  5 )
   exit
  ;; 

* )

 clear 
 ;;
esac 



}



function adminacc()
{

local username="user"
local password="pass"
clear
     printf "\n\n\t |----------------------------------------------------------------------       \n \n";
     printf "\t\t                       Admin Page                                                 \n\n";
     printf "\t     |--------------------------------------------------------------------------------";

    printf "\n      |-----------------------  LOGIN FORM  ------------------------------------------- ";
    printf "\n                       ENTER USERNAME:-";
	read adminusername;

	printf "\n                       ENTER PASSWORD :-"
	read adminpass;

   if [[ $adminpass == "pass" ]] && [[ $adminusername == "user" ]]
   then
      admin_menu  
    else
    	printf "please enter valid username and password"
    	
   fi



     



}

function  choose_account()
{

 clear 
local choice=


      printf "\n\n "
      printf " Admin  username and password is user and pass respectively  "
      echo  "          VOTING SYSTEM ACCOUNT            "
	  echo	" |--------------------------------------|"
	  echo	" |                                      |"
      echo	" |  1.  User  Account                   |"
	  echo	" |  2.  Admin Account                   |"
	  echo	" |  3.  Exit                            |"
	  echo	" |                                      |"
      echo	" |                                      |"
	  echo	" |--------------------------------------|"

read choice;
if   [[ "$choice" == 1 ]]; then
 	 useracc
elif [[ "$choice" == 2 ]]; then  	
     adminacc;
elif [[ "$choice" ==  3 ]]; then 
      echo "you are existing the system in 5 second.Thank you for using our system" 
      sleep 5 
      exit
else
	echo "Invalid choice"
	choose_account ;


 fi 


}
#findme=1;
 #grep "$findme" -n candidate.txt

 #echo $lines;

choose_account 

  