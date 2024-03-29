# BridgeForGit Workshop Scenario
# Admin and Developer experience 

## Login into Workshop Environment

Login at https://login.broadcom.com with the credentials shared in the email. Sharing couple of reference screenshots for the login process: 

<img src='images/bridge/b4g1.png' width='30%'>

<img src='images/bridge/b4g2.png' width='30%'>

Select “Sign In”

Select the “GTO Secure Access Cloud” Application. 

<img src='images/bridge/b4g3.png' width='30%'>

## BRIDGEFORGIT 

Section 1: 

1. Select the “BridgeForGit” tile. 

<img src='images/bridge/b4g4.png' width='30%'>

2. Authenticate via Github. Please enter the credentials shared by the instructor. 

<img src='images/bridge/b4g5.png' width='30%'>

<img src='images/bridge/b4g6.png' width='30%'>

3. BridgeForGit UI gets launched. Select "Create new mapping" on the top right. 

<img src='images/bridge/b4g7.png' width='30%'>

4. Select Template for "Simple Mapping Definition"

<img src='images/bridge/b4g8.png' width='30%'>

Enter the Github url. 
The Url will be of the format https://github.com/theworkshopuser/doggos-custxx. 
Replace XX with the number in your User ID. 

<img src='images/bridge/b4g9.png' width='30%'>

Select Next. 

Endevor Connection page will appear. Keep the defaults. 

<img src='images/bridge/b4g10.png' width='30%'>

Select Next. 

Enter the Branch name as “main”. Keep the other fields as defaults. 

<img src='images/bridge/b4g11.png' width='30%'>

For Map Inventory details.
- For Endevor System, Select “DOGGOS-DOGGOS”. 
- For Endevor Sub System, Select “Cust0XX-Cust0XX”. 
Note: Please select “Cust0XX-Cust0XX” by replacing XX with the number in your User ID.
For instance, if your User ID is mfwsuser16@demo.broadcom.com, replace XX by number 16 and select that option from drop down. 
- For Element Types, Select COBCOPY, COBOL, LNK, LNKINC

<img src='images/bridge/b4g12.png' width='30%'>

<img src='images/bridge/b4g13.png' width='30%'>

<img src='images/bridge/b4g14.png' width='30%'>

Select Next. 

<img src='images/bridge/b4g15.png' width='30%'>

Select “Initialize Mapping”

The Mapping initialization Begins.

<img src='images/bridge/b4g16.png' width='30%'>

<img src='images/bridge/b4g17.png' width='30%'>

Section 2: 

Access the workspace.  

From the Application Portal Page. The page where you selected “BridgeForGit” before, now select “MSD-Workshop”. Sharing a reference screenshot: 

<img src='images/bridge/b4g18.png' width='30%'>

This will launch the Workshop environment: 

<img src='images/bridge/b4g19.png' width='30%'>

Select “Workspaces” Tab. 

<img src='images/bridge/b4g20.png' width='30%'>

Hover over the paused status, it will list the option to Run. Select Run

<img src='images/bridge/b4g21.png' width='30%'>

This will launch the workspace. 

<img src='images/bridge/b4g22.png' width='30%'>

Please wait for the startup script to be finished. 

Section 3: 

Select the burger icon (three vertical lines), File -> Open Folder (Ensure the open folder is pointing to /home/developer and selct OK).

From the command line Terminal. Run the command: cd /home/developer

Now Clone the newly mapped github repo. 
Command: git clone git@github.com:theworkshopuser/doggos-custXX.git

Replace XX with the number in your User ID. For instance if you are user 16, then the command will be 
git clone git@github.com:theworkshopuser/doggos-cust16.git

<img src='images/bridge/b4g23.png' width='30%'>

Cd into the cloned repo directory and switch to main branch. 

Commands: 
cd doggos-custXX/
Note: Replace XX with number in your User ID. 

git checkout main

<img src='images/bridge/b4g24.png' width='30%'>   

In the Explorer tab, Open the Cobol file from the below path:   
doggos-cust0XX —> COBOL -> DOGGOSXX.CBL   
Note: Replace XX with the number from your User ID   

<img src='images/bridge/b4g25.png' width='30%'>

Make a Quick change - Update one of the existing comments. 
Change line 20 from 

<img src='images/bridge/b4g26.png' width='30%'>

To

<img src='images/bridge/b4g27.png' width='30%'>

Save the file. 

Track, commit and push the changes into the github repo. 

git add .   
git commit -m "updated a comment"   
git push   

<img src='images/bridge/b4g28.png' width='30%'>

At this point, User edited a cobol file, pushed the changes to Github. With BridgeForGit Mapping that is already performed between this Github repo to the Endevor, the changes are synched with the Endevor.
To validate that the changes got synced to Endevor, Perform the below steps. 

Select the burger icon (three vertical lines), File -> Open Folder (Ensure the open folder is pointing to /home/developer/doggos-gse/ and selct OK).

<img src='images/bridge/b4g29.png' width='30%'>

Launch the "Explorer for Endevor" extension, This extension is already configured to Endevor instance and Inventory location. Select the configurations that get listed. Sharing reference screenshots:

<img src='images/bridge/b4g30.png' width='30%'>

<img src='images/bridge/b4g31.png' width='30%'>

<img src='images/bridge/b4g32.png' width='30%'>

Expand the folder structure in Explorer tab and select "show history". See the below screenshot for reference.

<img src='images/bridge/b4g33.png' width='30%'>

This will list the file changes and Element history. 

<img src='images/bridge/b4g34.png' width='30%'>


