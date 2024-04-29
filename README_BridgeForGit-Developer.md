# BridgeForGit Workshop Scenario 

## Getting Started

1. Login the workshop system using the given URL, username and password
2. You are in the secure cloud environment which runs VS Code and is connected to the Mainframe
3. Make sure the initial build process has successfully completed. (**exit code: 0** and **Startup script finished** message in the active terminal)
4. Close the terminal from it's right top corner

## BRIDGEFORGIT 

In the Strong Network workspace, select the Burger icon on the top left (three horizontal lines), File -> Open Folder -> under /home/developer, select the doggos-cust0## repo where ## replaced by 09 or 10 etc. and Select Ok. Sharing a reference screenshot: 

<img src='images/bridge/bfg1.png' width='30%'>

This will load the "doggos-cust0##" github repository contents in the Explorer. From command line, switch to the corresponding git repository folder contents. Here is a reference screenshot: 

<img src='images/bridge/bfg2.png' width='30%'>


Edit a file under the below structure:

DOGGOS-CUST0## -> DOGGOS -> CUST0## -> COBOL -> DOGGOS##.CBL

Edit an existing comment by adding some text before or after the comment marker

Then run the Git commands:  
    git add .  
    git commit -a "Adding a comment"  
    git push  


Here is a reference screenshot: 

<img src='images/bridge/bfg3.png' width='30%'>

At this point, you have edited a cobol file, committed your changes and pushed them to Github. A previously created mapping between this GitHub repository and Endevor will synchronize the changes to Endevor in the background.

To validate that the changes were correctly updated in Endevor, Launch the "Explorer for Endevor" extension. This extension is already configured in your workspace with the correct Endevor instance and Inventory location. Select the instance name and location that gets listed. Sharing reference screenshots: 


<img src='images/bridge/bfg4.png' width='30%'>

<img src='images/bridge/bfg5.png' width='30%'>

Drill down in the Explorer for Endevor tree to the element that got updated via the git push. Open the element and you can see the update you made and pushed to the Git. The changes can also be observed via the Element History. 

This exercise shows that a push into GitHub repo is correctly synchronized with Endevor on the Mainframe (zD&T in this workshop scenario) as you have been able to validate with "Endevor For Explorer" extension. 