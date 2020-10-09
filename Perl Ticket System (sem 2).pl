#/usr/bin/perl

use strict;  #4 Pragmas used
use warnings;
use v5.10;
use DBI;
use POSIX qw(strftime);

my ($admin_or_user,
     $credentialName,   #32 Variable Declaration
     $credentialPass,
     $userchoice,
     $username,
     $userphone,
     $userinfo,
     $choice,
     $date,
     $ticket_id,
     %admin_array,
     @admin_array,
     $admin_name,
     $admin_pass,
     $admin_ID,
     $return,
     $priority,
     %key_words,
     $key_words,
     $length,
     $total,
     $key,
     $value,
     $key1,
     $value1,
     $admin_array,
     $support_tier);
my @star_array=("*") x 40;
my $current_date = strftime "%D",localtime; #3 Use of date mm/dd/yy  #15 Linux Command 1
$total = 0;
my $counter = 0;
system("clear"); #15 Linux Command 2
print"*******************INTERACTIVE TICKETING SYSTEM 1.0*************************\n";
print"***************DESIGNED BY: BEN LAUZON & DANIEL BALANTE*********************\n";
print"*****************************$current_date**********************************\n";
sleep 3;
system ("clear");
print"Welcome!\n";
sleep 2;

while ()
{
system ("clear");
print"Welcome!\n";
print"@star_array\n";
print"Are you an Administrator?(Y or N)\n";
print "print quit to exit program\n";
chomp($admin_or_user=<STDIN>); #6 Use of standard in

#establish global arrays
%key_words=(help=>1,urgent=>2,emergency=>3,executive=>3,sensitive=>4); #12a Created hash
%admin_array = (Joe_Blow=>'1234', Dan_Bal=>'P@ssw0rd2', Ben_Lauz=>'password');

#############################################################################
#############################################################################
#    THIS IS FOR ADMIN
#############################################################################
#############################################################################


if($admin_or_user=~/Y/i)  #1 Ignores case of user input
 {
   
   & query_login(); #17 Calls Subroutine
   
   
   if($return == 1)
   {
    system ("clear");
    
    while () #24 Looping Mechanism
    {
    
print "\t*************************ADMIN OPTIONS*************************\n";
print"Welcome $admin_name\n";
    
print "Please select one of the following:
 1) View Tickets
 2) Management
 3) Settings
 4) Quit \n";
     
chomp ($userchoice=<STDIN>);
     
  SWITCH: #22 Switch Statement
   {
    ($userchoice =~ /1/) and do
    {
     while(){  
  
 print("**********************Ticket options**********************
 1) View ticket database
 2) My Queue
 3) Ticket Descriptions
 4) Back to admin options\n");
 chomp ($choice=<STDIN>);
  
  
SWITCH:
   ($choice =~ /1/) and do    #11 Matching
      {
   my %attr = ( PrintError=>0, RaiseError=>1); 
   my $dsn = "DBI:mysql:ticket_db";
   my $username = "root";
   my $password = 'Password';
      
#connect to mysql database
my $dbh  = DBI->connect($dsn,$username,$password, \%attr);
say "************************Connected to ticket_db database************************\n";
  
 &query_links($dbh);
 #query data from table
 $dbh->disconnect();
  print ("Press enter to go back to Admin Options\n");
  chomp (my $x = <STDIN>);
  print "\n\n";
      
  };
    
     ($choice =~ /2/) and do
    {
     print "MY QUEUE\n";
     
     my %attr = ( PrintError=>0, RaiseError=>1); 
                                                  my $dsn = "DBI:mysql:ticket_db";
     my $username = "root";
     my $password = 'Password';
      
     #connect to mysql database
     my $dbh  = DBI->connect($dsn,$username,$password, \%attr);

printf ("****************Connected to %s's ticket_db database****************\n", $admin_name);
      
   query_links_myqueue($dbh);
  #query data from table
  $dbh->disconnect();
  print ("Press enter to go back to Admin Options\n");
  chomp (my $x = <STDIN>);
  print "\n\n";
   };
    
    ($choice =~ /3/) and do
    {
  while()
  {
   print "\tTICKET DESCRIPTIONS\n";
   print "\tENTER 'exit' TO QUIT\n";
   print "\tPlease enter ticket # to be viewed (please add .txt): \n";
   chomp ($ticket_id = <STDIN>);
 if ($ticket_id =~ /exit/i)
 {
  print"Exiting...\n";
  last;
 }
 
 if (-e $ticket_id) #checks if file exists
 {
  open (INFILE, $ticket_id) || die "Cannot open infile $!";
  print("~"x80);
  while (<INFILE>)
  {
           print"$_\n";  #13 Special Variable 1
  } 
  close (INFILE);
  print("~"x80);  #14 Repeat Operator
  print "End.\n";
  print "Press enter when done.\n";
  chomp (my $x = <STDIN>);
  last;
 }
 else
 {
  print "Cannot find file $ticket_id, please try again\n";
 }
 
  }
    };
    
  
    ($choice =~ /4/) and do
    {
     print("Exiting Ticket Options...\n");
     sleep(2);
     last;
    }
  }; #end of while loop
};  #end of management option 1


     #management option 2
     ($userchoice =~ /2/) and do
     {
     while ()  
{
print "\t*************************Management*************************
 1) View ticket priorities
 2) Assign ticket priorities
 3) View user info
\t4) Back to Admin options\n";
 chomp ($choice = <STDIN>);
 
 SWITCH:
 {
  ($choice =~ /1/) and do
  {

print "\t*************************TICKET PRIORITIES*************************\n";
   
   print("\tWord\t\tValue\n");
   
  foreach $priority(sort keys %key_words)  #12b Hash sorted
  #foreach $admin_name(sort keys %admin_array)
  {
 $length = length($priority);  #23 If Statement
 if ($length >= 8)
  {
   print"\t$priority\t$key_words{$priority} \n";   #12c Hash Applied
   print"\t------------------------------------\n";
  }
  else
  {
   print"\t$priority\t\t$key_words{$priority} \n";
   print"\t------------------------------------\n";
  }
  }
   print ("\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
   print ("\n\n");
   last;
  };
  
  ($choice =~ /2/) and do 
  {
   print "***ASSIGN TICKET PRIORITIES***\n";
   print "Type word you want to add:\n";
   chomp (my $key = <STDIN>);
   print"Type value (0-9) the word will be:\n";
   chomp (my $value = <STDIN>);
   
   $key_words=$key;
   $key_words{$key} = $value;
   
   print "Keyword $key added!\n";
   last;
  };
  ($choice =~ /3/) and do
  {
  print "***VIEW USER INFO***\n";
  open (INFILE, 'userinfo.txt') || die "Cannot open infile $!";
  print("~"x80);
  print"\n";
  while (<INFILE>)
  {
   print"$_\n";
  } 
  close (INFILE);
  print("~"x80);
  print "\nEnd.\n";
  print "Press enter when done.\n";
  chomp (my $x = <STDIN>);
   
   last;
  };
 }#end of switch 
  
($choice =~ /4/) and do
  {
   print "Exiting Management...\n";
   sleep 1;
  last;
   }
 
  
}#end of while loop 2
       
 }; #end of Management option 2
     
     ($userchoice =~ /3/) and do
     {
     while() #Settings option 3
{
print "\t*************************Settings*************************
 1) Show Admins
 2) Add Admin
 3) Back to Admin Options\n";
 chomp ($choice=<STDIN>);
 
 SWITCH:
 {
  ($choice =~ /1/) and do
  {
   #establish user array
   
   #print out user array
   foreach $admin_name(sort keys %admin_array)
   {
    print "user - $admin_name\npass - $admin_array{$admin_name}\n\n";
   $counter++;   #10 Counter
   }
   print "Press Enter when done.\n";
   <STDIN>;
   last;
  };
  ($choice =~ /2/) and do
  {
   print "***Add Admin***\n";
   print "type new username:\n";
   chomp ($key1 = <STDIN>);
   print"Type password for $key1:\n";
   chomp ($value1 = <STDIN>);
   
   $admin_array=$key1;
   $admin_array{$key1} = $value1;
   
   print "User $key1 added!\n";
   last;
   last;
  };
   
 }
  ($choice =~ /3/) and do
  {
   print "Exiting Settings...\n";
   sleep 1;
   last;
  }
} 
     }; # end of settings option 3
     
    }#end of switch for main menu options
    
  ($userchoice =~ /4/) and do # quit option for main menu
     {
      print "Exiting admin \n";
      sleep 3;
      last;
     }
     
    
} #end of big while loop
    } # end if(login)  
  
    
  } # end of if(admin) statement
  
  # subroutine of database option 1
sub query_links {
  my ($dbh) = @_;   #13 Special variable 2
  my $sql = "SELECT ticket_ID,
                    description,
                    agent,
                    Status,
                    submission_date
             FROM tickets";
  my $sth = $dbh->prepare($sql);
 
  # execute the query
  $sth->execute();

  while(my @row = $sth->fetchrow_array()){
     printf("%s\t\t%s\t\t%s\t%s\n\t%s\n",$row[0],$row[1], $row[2], $row[3], $row[4]); #5 Formatted Output
     print("~"x80);
     print("\n");
  }       
  $sth->finish();
}
  #end of query_links subroutine

sub query_links_myqueue {                       #16 Create Subroutine
  my ($dbh) = @_;
  my $sql = "SELECT ticket_ID,
                    description,
                    agent,
                    Status,
                    submission_date
             FROM tickets";
  my $sth = $dbh->prepare($sql);
 
  # execute the query
  $sth->execute();

  while(my @row = $sth->fetchrow_array()){
  if ($row[2] eq $admin_name) #only selects tables that have admins name
   {
     printf("%s\t\t%s\t\t%s\t%s\n\t%s\n",$row[0],$row[1], $row[2], $row[3], $row[4]);
     print("~"x80);
     print("\n");
      }
  }       
  $sth->finish();
}
 # end of query_links_myqueue subroutine
 
  # login subroutine
sub query_login {
 
 print "Please login: \n";
  
  #print "Admin ID: ";
  #chomp ($admin_ID = <STDIN>);

  print "Username: ";
  chomp ($admin_name=<STDIN>);

  print"Password: ";
  chomp($admin_pass=<STDIN>);

  if(exists $admin_array{$admin_name} && $admin_array{$admin_name} eq $admin_pass) #need both ^ because error msg will occur
  {
   print("login successful...\n");
   sleep (2);
   $return = 1;
   return $return;
  }
  else
  {
   print("login failed. Please try again.\n");
   sleep (2);
   $return = 0;
   return $return;
  }
 
}
#end of query_login subroutine 

#############################################################################
#############################################################################
#    THIS IS FOR USER
#############################################################################
#############################################################################


if($admin_or_user=~/N/i)   #Enters into User Mode functions
{
 system("clear");
 while()  #Infinite loop for interactive menu, until user exits
 {
  print "@star_array\n";
  print"Please select one of the following:
   1) Submit a ticket
   2) Contact an Admin
   3) View Ticket Information
   4) Exit\n";
   chomp($userchoice=<STDIN>);
   
   SWITCH:
   {
    ($userchoice=~/1/) and do 
     {
      
      &ticket_creator(); #19 Calls Outfile Subroutine
      last;
     };
     
     ($userchoice=~/2/) and do   #2 Report printed to OUTFILE 
     {
      print "@star_array\n";
      print "Please enter your name: \n";
      chomp($username=<STDIN>);
      print"Welcome $username, please enter your phone number: \n";
      chomp($userphone=<STDIN>);
      open(OUTFILE,'>>',"userinfo.txt") || die "Cannot write to file $! \n";
      print OUTFILE "User\t\tPhone#\n";
      print OUTFILE "$username\t\t$userphone\n";
      close OUTFILE;
      last; 
     };
     
     ($userchoice=~/3/) and do 
     {
      &get_ticket_info(); #21 Another Subroutine Call
      last;
     };
     
   };
  if($userchoice=~/4/)
  {
   print "Exiting menu \n";
   sleep 3;
   last;
  }; 
  print "Invalid input, please make a valid selection\n"; #30 Error check in Switch 
 }                    #31 Error check for bad input  
}



sub ticket_creator {                 #18 Outfile Subroutine
  system("clear");
  print "@star_array\n";
  print "Please enter your name: \n";
  chomp($username=<STDIN>);
  print"Welcome $username, please enter your phone number: \n";
  chomp($userphone=<STDIN>);
  open(OUTFILE,'>>',"userinfo.txt") || die "Cannot write to file $! \n";
  print OUTFILE "User\t\t\tPhone#\n";
  print OUTFILE "$username\t\t\t$userphone\n";
    close OUTFILE;
    &ticket_info();
    
     sub ticket_info{ #20 Another subroutine   
     
     use v5.10; 
     use DBI;
      
     # MySQL database configurations
     my $dsn = "DBI:mysql:ticket_db";
     my $username = "root";
     my $password = "Password";
   

      
   my @infos = get_info();
   # connect to MySQL database
   my %attr = (PrintError=>0,RaiseError=>1 );
   my $dbh = DBI->connect($dsn,$username,$password,\%attr);
   # insert data into the tickets table
my $sql = "INSERT INTO  tickets(Ticket_ID,Description,Agent,Status,submission_date,Support_Tier)  
       VALUES(?,?,?,?,?,?)";
#5 Output formatted to mySQL database
      
     my $stmt = $dbh->prepare($sql);
      
     # execute the query
     foreach my $info(@infos){
       if($stmt->execute($info->{Ticket_ID},$info->{Description}, $info->{Agent}, $info->{Status}, $info->{submission_date}, $info->{Support_Tier})){
       say "Ticket $info->{Ticket_ID} created successfully!";
       sleep 2;
       }
      
     }
     $stmt->finish();
      
     # disconnect from the MySQL database
     $dbh->disconnect();
      
     sub get_info{
      my $cmd = '';
      my @infos;
      # get info from the command line
      my($ticket_id,$description,$agent,$status,$support_tier);
      
      # repeatedly ask for ticket data from command line
      do{
   
        $ticket_id = id_generator();
   print"Your ticket ID Number is $ticket_id, please save this number for future reference.\n";
        
   print"Which device or software requires attention? (ex: printer, network etc.) : \n";
        chomp($description=<>);
         
        
  open FILE, "agents.txt" or die "Could not open file: $! at line $.\n"; #8a Error check on open
  my @array=<FILE>;   #7 Reads from INFILE, most infile reading done through mySQL              #7b Assigns data to an array
       close FILE;  #8b close infile
 
      print"would you like to request one of these agents?\n";
       foreach (@array)
       {
        print"$_\n"; #27 Print data from an array
       }
       print"type 'random' for random\n";
       chomp(my $specific_agent=<STDIN>);
 
       if ($specific_agent eq 'random'){
       chomp($agent=$array[rand @array]);
       }
       else{
       ($agent=$specific_agent);
       }
  

        $status="Active";
        $date=`date`;
    print"For more effective service, please describe your issue in more detail: \n";
        
   open(OUTFILE,'>>',"$ticket_id.txt") || die "Could not open file $! at line $.";

   print"Describe your issue in detail: (Press Enter twice to save) \n";

   while(<STDIN>)
    {
         print OUTFILE $_;
         last if /^$/;
               }
   close(OUTFILE);
            
  $support_tier = &tier_escalator($ticket_id);
         
         
      
        
 my %info = (Ticket_ID=> $ticket_id,Description=>$description, Agent=> $agent, Status=> $status,submission_date=>$date,Support_Tier=>$support_tier);
      
  push(@infos,\%info); #29 use of push
        
        
  print("\nDo you want to submit another ticket? (Y/N)?");
  chomp($cmd = <STDIN>);
  $cmd = uc($cmd);
  }until($cmd eq 'N');
  return @infos;
      
     }
     } 

sub get_ticket_info{     
use DBI;
system("clear");
 
# MySQL database configurations
my $dsn = "DBI:mysql:ticket_db";
my $username = "root";
my $password = "Password";
 
# connect to MySQL database
my %attr = ( PrintError=>0,  # turn off error reporting via warn()
             RaiseError=>1   # report error via die()
           );
my $dbh = DBI->connect($dsn,$username,$password,\%attr);
 
# query data from the tickets table
query_tickets($dbh);
 
# disconnect from the MySQL database
$dbh->disconnect();
sub query_tickets{
  # query from the tickets table
  print"Please enter your Ticket Number: ";
  chomp(my $ticketnum=<>);
  my ($dbh) = @_;
  my $sql = "SELECT * FROM tickets where Ticket_ID = $ticketnum";
  my $sth = $dbh->prepare($sql);
 
  # execute the query
  $sth->execute();
  print("ID#\tDescription\tAgent\tStatus\tDate\n");
  while(my @row = $sth->fetchrow_array()){
     my ($id,$description,$agent, $status, $date) = @row;
     printf("%s\t%s\t\t%s\t%s\t%s\n",$id,$description,$agent,$status,$date);
  }       
  $sth->finish();
}
} 
sub id_generator{

my @chars = (0 .. 9);
my $id_num = join("", @chars[ map { rand @chars } ( 1 .. 4 ) ]);  #28 Use of Join
return "$id_num";
}
sub tier_escalator {
  
  my(
   $string,
   $element,
   @array,
   $number,
   );
   
   
  
  open(INFILE,"@_.txt") or die "Could not open file $! at $.";
  $string = <INFILE>;       
  @array = split(/ /,$string);
  foreach $element(@array)
  {
         if(exists $key_words{$element})
   { 
    
    $number = $key_words{$element};
    $total=$total + $number;
     

if ($total == 2 )   #tier support based on keywords and their cumulative value. 
  {                            
      $support_tier=2;     
  }
   elsif($total>=3)
  {
   $support_tier=3;
  }
 else
                {
 $support_tier=1;
 }
 return $support_tier;
 }
  }close(INFILE);
   
}

}


     
    #QUIT#
if($admin_or_user=~/quit/i)
{
 print "Exiting Ticket Manager...\n";
 sleep 3;
 last;
} 
}

