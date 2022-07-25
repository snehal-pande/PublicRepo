
Feature: TeleHack_Utility
#########################################################
#Description: Verifying various actions can be performed on the Telehack website via a terminal
#website:telehack.com
#Functional Area: Terminal
#Test Case Type: Regression
#Dataset: None
#Test Case Inputs: None
#Test Case Detail Input CSV: 
#Test Case Verification Approach:A successful test case will be verified by a complete run and by manually comparing the echoed variables against the screenshots taken by Cycle. 
#######################################################################


Background: 
#####################################################################
# Description:  Assigning wait in the variable
####################################################################
Given I assign 1 to variable "short_wait"
Given I assign 3 to variable "mid_wait"
Given I assign 10 to variable "long_wait"

@wip @public
Scenario: Connect to TeleHack
#############################################################
# Description: For Connecting TeleHack Terminal
# Inputs:
#	None
# Outputs:
# 	None
#############################################################
When I "Connect to Telehack.com"
	Given I open terminal connected to "telehack.com" sized to 24 lines and 77 columns 
	Then I "verify that the user at TeleHack home screen"
    If I see "Connected to TELEHACK" in terminal within $mid_wait seconds
		Then I echo "Verified that you are at TELEHACK home screen"
	Else I echo "You are not at TELEHACK home screen"
	Endif

@wip @public
Scenario: Capture Zork Description
#############################################################
# Description: To capture Zork description
# Inputs:
#	None:
# Outputs:
# 	None	
#############################################################
Given I "Capture zork description"
#	Once I see "Connected to TELEHACK" in terminal
   	Then I enter "HELP" in terminal
	And I "scroll till user see zork menu"
    
While I do not see $help_name in terminal within $mid_wait seconds
	Then I move cursor "DOWN" in terminal 
    And I wait $short_wait seconds
EndWhile

	#And I wait $short_wait seconds
Then I locate $help_description in terminal
	And I wait $short_wait seconds
	And I copy terminal line 22 from column 32 through next 8 columns to variable "Description"	

Given I "verify help description is equal to .csv description"
	If I verify text <help_description> is equal to $Description
		And I echo "I verify help description"
	Else I echo "Not Verify help description"
	EndIf
	And I wait $mid_wait seconds
	And I enter "q" in terminal
	And I execute scenario "Back to Home Screen"

@wip @public
Scenario: Verify Rolls
#############################################################
# Description: Verify Rolls
# It will go to roll game and wait till game to be completed. It will add two number which is displayed on the screen
# Outputs:
# 		sum : Sum of two variable is less than 13
#############################################################
Given I "Enter the roll"
	When I enter "roll" in terminal
	
While I do not see cursor at line 8 column 2 in terminal
	Then I wait $mid_wait seconds
EndWhile

	Then I "Copy 1st and 2nd number to the variable random1 and random2"
	And I copy terminal line 7 columns 6 through 6 to variable "random1"
	And I copy terminal line 7 columns 16 through 16 to variable "random2"
	And I convert string variable "random1" to INTEGER variable "random1"
	And I convert string variable "random2" to INTEGER variable "random2"

	Then I "sum of two random number and store in the random1 variable"
	And I execute Groovy "sum = random1 + random2"

When I "verify sum of two number is beneath to 13"
	If I verify number $sum is less than 13
		Then I echo "Sum of two number is less than 13"
    	And I wait $short_wait seconds
    	And I execute scenario "Back to Home Screen"
	Else I echo "Sum of two number is not less than 13"
	Endif


@wip @public
Scenario: Back to Home Screen
#############################################################
# Description: It will go back to home screen
# Inputs:
#	None:
# Outputs:
# 		
#############################################################
Given I "Go Back to Home Screen"
	When I enter "?" in terminal
    
If I see "Command, one of the following:" in terminal within $mid_wait seconds
	Then I echo "Verified that you are at Home Screen"
Else I echo "You are not at Home Screen"
EndIf



@wip @public
Scenario: Start Zork
#############################################################
# Description: Start Zork
# It will start zork game and verify you are at zork screen
# Inputs:
#	None
# Outputs:
# 	None
#############################################################
Given I "Steps for start the zork screen"
	Then I enter "zork" in terminal
	And I wait $mid_wait seconds
    
    When I locate "Release" in terminal
	Then I copy terminal line $terminal_line columns $terminal_column through 11 to variable "zork_release"
	And I echo $zork_release
    
    And I "verify that the Zork game start"
    If I see "West of House" in terminal within $mid_wait seconds
        Then I echo "Arrived at zork screen"
        And I wait $mid_wait seconds
    Else I echo " Not arrived at zork screen"
    EndIf


@wip @public
Scenario: Enter the House
#############################################################
# Description: Enter the House
# It will go to the house and verify various direction of the house
# Inputs:
#	None:
# Outputs:
# 	None
#############################################################
Given I "enter into south of house"
	Then I enter "go south" in terminal   
	If I see "South of House" in terminal within $mid_wait seconds
		Then I echo "Verified you are at South of the house"
	Else I echo "You are not at south of the house"
	EndIf
	And I wait $mid_wait seconds
   
Given I "enter into east of house"
	Then I enter "go east" in terminal
	If I see "Behind House" in terminal within $mid_wait seconds
		Then I echo "Verified you are at Behind the house"
  	Else I echo "You are not at Behind the house"
  	EndIf

Given I "Open window"
	Then I enter "open window" in terminal 
  	If I see "you open the window far enough to allow entry" in terminal within $mid_wait seconds
  		Then I echo "Verified you are allow to enter"
    Else I echo "You are not allow to enter"
  	EndIf

Given I "enter into kitchen in house"
	Then I enter "enter window" in terminal
  If I see "Kitchen" in terminal within $mid_wait seconds
      Then I echo "Verified you are at Kitchen"
  Else I echo "You are not at Kitchen"
  EndIf
	And I wait $mid_wait seconds


@wip @public
Scenario: Die by a Gure
#############################################################
# Description: Die by a Gure
# It will go to up and north direction and verify that you are eaten by gure
# Inputs:
#	None:
# Outputs:
# 	grue_message- message from go north screen
#############################################################
Given I "Enter the Go up house"
	Then I enter "go up" in terminal
    And I wait $mid_wait seconds
    
And I "verify that Go up message"
   If I see "It is pitch black.  You are likely to be eaten by a grue." in terminal
        Then I echo  "I am likely to be eaten by a grue"
    Else I echo "You are not likely to be eaten by grue"
    EndIf
  	And I wait $short_wait seconds

And I "Enter Go north"
	Then I enter "go north" in terminal
  	And I wait $short_wait seconds

And I "verify go north message"
  If I see "Oh no! You are walked into the slavering to be eaten by a grue. " in terminal
  	Then I echo "Verified that You are eaten by grue"
  else I echo "Not eaten by grue"
  EndIf

Then I copy terminal line 7 columns 1 through 77 to variable "grue_message"
  And I echo $grue_message
  And I wait $short_wait seconds
##############################################
@wip @public
Scenario: Verify FigletFont
#############################################################
# Description: figlet Fonts
# Figlet command will verify different fonts 
# Inputs:
#	None:
# Outputs:
# 	grue_message- message from go north screen
#############################################################
Given I "Enter figlet"
	Then I enter "figlet [\$figlet_font] Successfully printed" in terminal
    And I wait $mid_wait seconds
    
And I "verify that Figlet Font is Successfully printed"
   If I see "[\$figlet_font] Successfully printed" in terminal
        Then I echo  "Passed"
    Else I echo "Failed"
    EndIf
  	And I wait $short_wait seconds
#########################################################
@wip @public
Scenario: uupath
#############################################################
# Description: figlet Fonts
# Figlet command will verify different fonts 
# Inputs:
#	None:
# Outputs:
# 	grue_message- message from go north screen
#############################################################
Given I "Enter uupath"
	Then I enter "uupath" in terminal
	 And I wait $mid_wait seconds
	Then I see "host?" in terminal
	Then I enter $host in terminal
    And I wait $mid_wait seconds
    
And I "verify that shortest virtual path is printed"
   If I see "telehack!oracle!apple!mtxinu!basis" in terminal
        Then I echo  "Passed"
    Else I echo "Failed"
    EndIf
  	And I wait $short_wait seconds
@wip @public
Scenario: Quite Game
#############################################################
# Description: Quite Game
# It will go out of the game
# Inputs:
#	None:
# Outputs:
# 	None
#############################################################
Given I enter "Quit" in terminal
# 	And I see "Are you sure you want to quit?" in terminal within $long_wait seconds
	Then I enter "yes" in terminal
	And I wait $mid_wait seconds
	And I execute scenario "Back to Home Screen"


@wip @public
Scenario: Close Terminal
#############################################################
# Description: Close Terminal
# It will Close the terminal
# Inputs:
#	None:
# Outputs:
# 	None
#############################################################
Given I close terminal