@echo off
setlocal EnableDelayedExpansion
title Digital World
mode 300
color 0C

:: Lucky you! You have decompiled the game's source! 
:: Please do not copy this game's code and spread it across the internet. I have spent weeks creating this.
:: Also, if you are going to make changes to this game, please read the comments that I have added
:: Features as the saving, require you to change the saving, variables etc. so if you are adding variables
:: Make sure to change the "saving variables" which will stay near the bottom
:: 
:: Also, if you are wondering, I may make a 2nd version of this game, with more features and more complex,
:: Clean code. :)

::Statistics, Do not mess with unless you know what you are doing //////

set hp=100
set armour=0
set exp=1
set money=10
set gun=no
set gun_type=none
set lvl=1

::Misc Settings

set custom_settings=no
set place_stat="None set"
set isSoundPlaying=no
set barMoneyGave=0
set ifVisitedCity=no



::Enemy Statistics, Make sure to do these! These are very important when you are going to add fights in the game.

set enemy_hp=100
set enemy_armour=0
set enemy_gun=no
set enemy_name=Unknown

::make a enemy level

::Limits
set gunlimit=15
set gunshots_fired=0
set money_won=0
set exp_won=0

::Misc Limits
set money_limit=100000
:: Money limit is 100,000


:: / Debug Options /
:: goto menu
:: goto fight
:: goto City
:: goto Inventory
:: goto bar 
:: goto scavenge_hunt
:: ///////////

:menu
cls
echo.
echo                                /////////////////
echo                                / Digital World /
echo                                /////////////////
echo                               Made by MineKat Studio
echo. 
echo.
echo NOTE: Please do ignore the size of your window at the moment! It is because
echo this game uses some ASCII graphics that are HUGE! So please do bare in mind,
echo I am trying to lower the size down!
echo.
echo 1) Start new game
echo 2) Load game
echo 3) Settings
echo 4) Credits
echo 5) Exit
echo.
set /p menuchoice= Choice:

if %menuchoice% == 1 (
    goto Introduction
)
::Load Game is not complex but I did have some trouble, do not mess with it please.
if %menuchoice% == 2 (
    goto loadgame
)
if %menuchoice% == 3 (
    goto Settings
)
if %menuchoice% == 4 (
    goto credits_section
)
if %menuchoice% == 5 (
    exit
)
if %menuchoice% GEQ 6 (
    cls 
    echo That is not a valid option!
    timeout /t 3 /nobreak >nul
    goto menu
)

:check_hack
:: Checks if the game is been modified
if %money% GTR %money_limit% (
	goto hacked_game
) else goto bar

:loadgame
if NOT EXIST settings\save.txt (
    echo There is no save file! Please keep all saves in the "Settings" folder for proper compatibility
    timeout /t 3 /nobreak >nul
    goto menu
)
(
set /p name=
set /p hp=
set /p exp=
set /p money=
set /p gun=
set /p armour=
set /p gun_type=
)<settings\save.txt
echo.
echo Game succesfully loaded!
timeout /t 2 /nobreak >nul
goto check_hack



::Start of the settings
:Settings
cls
echo.
echo ////////////
echo / Settings /
echo ////////////
echo.
echo More settings are coming soon! I am working on this game so much
echo.
echo Which settings do you want to change? 
echo 1) (UNDER CONSRUCTION!)
echo 2) Save the settings (Recommended if you changed the settings)
echo 3) Exit
echo.
set /p settings_choice= Choice:

if %settings_choice% == 2 (
	goto savesettings
)

:savesettings
(
	echo %custom_setting%
)>settings\config.txt
echo Save Successful!
pause >nul
goto Settings

::End of the settings

:Introduction
cls
echo.
echo Hello! I am your guide for this game! 
echo My name is Kat-a-Tron 3000, Version 3.0.1.2
echo I cannot help you fight, trade, sell etc.
echo I can guide you through the controls and what could come next.
echo.
echo There are several save points around the game so please
echo save frequently!
echo.
timeout /t 3 /nobreak >nul
echo.
echo So, what is your name?
echo.
set /p name= Name:
echo.
echo So, your name is %name%
time /t 3 /nobreak >nul
goto bar

::Bar Related things here!

:bar
cls
echo.
echo Welcome to the bar! What do you want today?
echo.
echo Your Statistics:
echo.
echo Name: %name%
echo Health: %hp%
echo Experience: %exp%
echo Money: %money%
echo.
echo 1) A Drink
echo 2) Start a random fight
echo 3) Point gun at the bartender
echo 4) Go outside
echo.
echo 5) Save Game (RECOMMENDED)
echo 6) Go to Menu
echo 7) Exit
echo.
set /p barchoice= Choice:


if %barchoice% == 1 (
    goto barshop
)
if %barchoice% == 2 (
    goto fight
)
if %barchoice% == 3 (
    goto barholdup
)
if %barchoice% == 4 (
    goto City
)
:: Save option
if %barchoice% == 5 (
    cd \settings
    (
        echo %name%
        echo %hp%
        echo %exp%
        echo %money%
        echo %gun%
		echo %armour%
		echo %gun_type%
    )>settings\save.txt
    cd..
    goto bar
)
if %barchoice% == 6 (
    goto menu
)
if %barchoice% == 7 (
    exit
)

:: Bar Options, Misc

:barholdup
cls
if %gun% == no (
	cls 
	echo You do not have a gun! 
	echo The Bartenders' laugh at you!
	pause >nul
	goto bar
)
if %gun% == yes (
    cls 
    set /a barMoneyGave=%random% %%50-25%
	echo You point your gun at the bar-tender.
	echo He turns shocked and starts handing money into a bag
	echo.
	echo He gave you, %barMoneyGave%
	echo.
	echo You now have, %money%
	pause >nul
	goto City
)

::Start of City //

:City
cls
echo You look around the unfamilar place. 
echo You notice a few unique objects
echo and people around the city.
timeout /t 3 /nobreak >nul
cls
set /a place_stat="Downing Lane" 
echo.
echo Welcome to the city of! Old York!
echo. 
echo You currently are in: 
echo / %place_stat% /
timeout /t 2 /nobreak >nul
echo What do you want to do?
echo.
echo 1) Go back to the bar.
echo 2) Look around the place
echo 3) Go to the suspicous person
echo 4) Steal a car 
echo.
echo 5) Check your inventory
echo.
set /p city_choice= Choice:

if %city_choice% == 1 (
    goto bar
)
if %city_choice% == 2 (
    goto scavenge_hunt
)
if %city_choice% == 3 (
    goto city_suspiciousCitizen
)
if %city_choice% == 4 (
    goto city_stealCar
)
if %city_choice% == 5 (
    goto Inventory
)

:scavenge_hunt
cls
for %%i in (h u n t i n g . . . ) do (
   set /p a=%%i<nul
   ping 0.0.0.0 -n 1.5>nul 2>&1
)
echo.
echo You have found:
pause >nul

:city_suspiciousCitizen

:city_stealCar

::End of City //


::Start of barshop
:barshop
cls
echo.
echo ///////////////////////
echo / Welcome to Bar Shop /
echo ///////////////////////
echo.
echo What would you like today?
echo.
echo Money: %money%
echo.
echo :Drinks:
echo.
echo /:/ Bottle of Whiskey (50 Money) \:\
echo /:/ Shot of Whiskey (15 Money) \:\ 
echo.
echo /:/ Bottle of Vodka (100 Money) \:\
echo /:/ Shot of Vodka (40 Money) \:\
echo.
echo.
echo 1) Bottle of Whiskey
echo 2) Shot of Whiskey
echo 3) Bottle of Vodka
echo 4) Shot of Vodka
echo.
echo 5) Go back to menu
echo.
set /p barchoice_drink= Choice:

if %barchoice_drink% == 1 (
	goto WhiskeyPayment_Bottle
)
if %barchoice_drink% == 2 (
    goto WhiskeyPayment_Shot
)
if %barchoice_drink% == 3 (
    goto VodkaPayment_Bottle
)
if %barchoice_drink% == 4 (
    goto VodkaPayment_Shot
)

if %barchoice_drink% == 5 (
	goto menu
)

::WhiskeyPayment_Bottle
:WhiskeyPayment_Bottle
if %money% LSS 50 (
    cls
    echo You do not have enough money!
    pause >nul
    goto barshop
)
if %money% GEQ 50 (
    set /a money=%money%-50
    cls
    echo You took a bottle of whiskey....you feel doozy.
    pause >nul
    if NOT EXIST content\objects\inventory\bottleAlcohol.entity (
    (
         echo set bottleCount=1
         echo set objectname2="Bottle of Alcohol"
         )>content\objects\inventory\bottleAlcohol.entity
    )
    goto barshop
)

::WhiskeyPayment_Shot
:WhiskeyPayment_Shot
if %money% LSS 15 (
    cls
    echo You do not have enough money!
    pause >nul
    goto barshop
)
if %money% GEQ 15 (
    set /a money=%money%-15
    cls
    echo You took a shot of whiskey....you feel doozy.
	set /p drunkness_lvl=10
    pause >nul
    goto barshop
)

::VodkaPayment_Bottle
:VodkaPayment_Bottle
if %money% LSS 100 (
    cls
	echo You do not have enough money!
	pause >nul
	goto barshop
)
if %money% GEQ 100 (
    set /a money=%money%-100
	cls
	echo Bartender: Straight from russia! I've tried it before, it is very strong. 
	echo.
	echo You did not listen to the bartender at all,
	echo you took the bottle and chugged all of it down.
	echo.
	timeout /t 2 /nobreak >nul
	cls
	echo You feel very doozy.
	echo You walked to the table, wobbling side to side.
	echo You write a note saying, DO NOT TAKE A BOTTLE OF VODKA, in rough hand-writing
	if NOT EXIST content\objects\inventory\note_vodka.entity (
	(
	        echo set isReadable=yes
            echo set objectname1="Vodka Note"
            echo set readable_text="DO NOT TAKE A BOTTLE OF VODKA"
	    )>content\objects\inventory\note_vodka.entity
	)
    :: Checks if it has bottle or not
    if NOT EXIST content\objects\inventory\bottleAlcohol.entity (
        (
            echo set bottleCount=%bottleCount%+1
            echo set objectname2="Bottle of Alcohol"
        )>content\objects\inventory\bottleAlcohol.entity
    )
	pause >nul
	goto barshop
)



:: End of Bar Shop

:: Start of fight
:fight

cls

if %hp% LEQ 0 (
    goto Loss
)
if %enemy_hp% LEQ 0 (
    goto Victory
)

echo.
echo You started a fight with %enemy_name%
echo.
echo. 
echo / Your Stats /
echo Health: %hp%
echo Armour: %armour%
echo Experience: %exp%
echo Money: %money%
echo.
echo / %enemy_name%'s Stats /
echo Health: %enemy_hp%
echo Armour: %enemy_armour%
echo.
echo What do you want to do?
echo.
echo 1) Press P for a Punch
echo 2) Press K for a Kick
echo 3) Press G to use your gun (Doesn't apply if you don't have a gun)
echo 4) Press R or 4 to run away
echo.
set /p fight_option= Choice:

if %fight_option% == P (
	goto punch_attack
)
if %fight_option% == K (
	goto kick_attack
)
if %fight_option% == G (
	goto gun_attack
)
if %fight_option% == 4 (
	goto run_away
)
if %fight_option% == R (
    goto run_away
)

:punch_attack
cls
set /a enemy_hp=%enemy_hp%-%random% %%13-4%
echo You throw a swing at the enemy!
echo The enemy's health went down to, %enemy_hp%
echo.
set /a hp=%hp%-%random% %%12-5%
echo Also the enemy threw a swing at you! 
echo Your health went down to, %hp%
pause >nul
goto fight

:kick_attack
cls 
set /a enemy_hp=%enemy_hp%-%random% %%11-6%
echo You kicked the enemy!
echo The enemy moaned in pain.
echo It's health went down to, %enemy_hp%
echo.
set /a hp=%hp%-%random% %%12-4%


:gun_attack
cls
if %gun% == no (
    set /a hp=%hp%-%random% %%12-5%
	echo You do not have a gun! The enemy took a swing and hit at you!
	:: Fix this above. Doesn't seem to change at all. Find a alter way!
	echo Your health went down to, %hp%
	pause >nul
	goto fight
) else (
    echo You shot your %gun_type%.
	echo You dealed only a bit of damage to the enemy, since your bullets are blunt.
    ::Add the attack feature
)

:: Add the attack feature, where you don't have a gun but the enemy swings at you
:: Also add a feature where when you win, you gain exp 

:run_away
cls
echo You have successfully ran away from the enemy! 
echo Though, you have lost 1 EXP from that battle.
set /a exp=%exp%-1 
echo Your exp is now, %exp%
echo.
timeout /t 3 /nobreak >nul
goto bar



::End of Fight

:Victory
set /a money_won=%random% %%50-20% 
set /a exp_won=%random% %%100-55%
set /a money=%money%+%money_won%
set /a exp=%exp%+%exp_won%
echo.
echo You have successfully won against, %enemy_name%!
echo.
echo You have gained %money_won%, more money
echo You have gained %exp_won%, more money
echo.
pause


:Loss
echo.
echo You have lost against, %enemy_name%!
echo You have lost 

pause 

::add where you lost %exp_lost% etc.

::Start of Inventory
:Inventory
echo.
echo You take your bag and open it! 
timeout /t 2 /nobreak >nul
echo You have:
if EXIST content\objects\inventory\note_vodka.entity (
    echo Vodka Note
)
if EXIST content\objects\inventory\bottleAlcohol.entity (
    echo Bottle of Alcohol
)

::End of Inventory



:Arrested
cls
color 01
set /a money=%money%-20
set /a gun=no
set /a gun_type=none
echo.
echo       //////////
echo       / BUSTED /
echo       //////////
echo.
echo  You've got arrested! 
echo  All of your weapons are gone! 
echo  You've also got fined, -20 Coins!
echo.
echo  Your money went down to, %money%
echo.
echo  What do you want to do now?
echo.
echo 1) Go to the city
echo 2) Go to the bar
echo 3) Go to the menu
echo 4) Save the game
echo 5) Exit
echo.
set /p bustedchoice= Choice:

if %bustedchoice% == 1 (
    goto City
)
if %bustedchoice% == 2 (
    goto bar
)
if %bustedchoice% == 3 (
    goto menu
)
if %bustedchoice% == 4 (
    
)
:: Add a save option above!






:: This is the check from the very top, if someones money is higher
:hacked_game
cls
echo.
echo Hmm, what have you been up to? I see that you modified the save file?
echo You have probably changed the money, experience etc.
echo How about change it to a reasonably good amount instead? I want people 
echo to play the game properly.
echo I don't like cheaters, exploiters or hackers.
echo Don't try it :)
echo.
pause >nul
exit

::Leave credits at the bottom

:credits_section
cls
echo.
type "content\graphics\logo_transparent.txt"
echo.
echo               Main Developer:
echo               MineKat Studio
echo.
echo               Made in Batch, also known as .bat
echo.
echo               Encrypted with Bat to Exe, some other features come
echo               from Advanced Bat to Exe
echo. 
echo               I have hidden some easter eggs but a very few, if you find them
echo               tweet at me: @MineKat_Studio
echo.
echo               I thank all of my testers, family and friends for making this Game
echo               possible!
echo.
echo.
echo               Make sure to check out my YouTube Channel!
echo.
echo               Thanks for playing!
echo.
pause >nul
goto menu



endlocal