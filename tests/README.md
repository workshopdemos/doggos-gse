# Doggos Regression Test Suite 

-----intro----

## Prerequisites
Before you attempt to install the Doggos Regression Test Suite project, ensure you meet the following prerequisites:

* Test4z is deployed, configured and running on your z/OS system.
* Visual Studio Code (VS Code) is installed.
* Node.js is installed.
* Ensure VS Code uses bash to execute shell (.sh) scripts. 
* If you have VS Code running, restart it.

## Installing
Once you have met the prerequisites,

1. Clone the repository to your local machine and open it with VS Code.
2. Navigate to the setup script [setup.sh](/.scripts/setup.sh) and put your username to the **USER_NAME** variable.
3. Open a new terminal and run the following command:

        npm install
   _During the npm install, some of the dependencies may throw errors, as long as npm install doesn't interrupt, this errors can be ignored._
4. Now you can navigate to the [doggos.test.ts](/src/test/doggos/doggos.test.ts) file and run it using the following command:
        
        npm run test doggos

