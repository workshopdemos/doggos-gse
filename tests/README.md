# Doggos Regression Test Suite 

-----intro----

## Prerequisites
Before you attempt to install the Doggos Regression Test Suite project, ensure you meet the following prerequisites:

* Test4z is deployed, configured and running on your z/OS system.
* Visual Studio Code (VS Code) is installed.
* Node.js is installed.
* Ensure VS Code uses bash to execute shell (.sh) scripts. 
* If you have VS Code running, restart it.

## Configuration
Once you have met the prerequisites,

1. Open a new terminal
2. Navigate to the test4z package using the command below:

        cd tests
3. Run the following command to install the node dependencies. Test4z configuration will be started following the 
dependency installation, enter your username when command prompt asks.

        npm install
        
## Running The Test Case

1. Navigate to the **test4z/src/test/doggos/doggos.test.ts** file and check the regression test codes.
2. Run the test suite using the following command:

        npm run test
        
3. Verify the successful test execution.

## Extending the test suite

1. Navigate to the **test4z/.scripts/files/DOGGOS.INPUT** file. Add a new breed with a number of adoptions, or change
the number of adoptions for an existing breed.
2. Upload the new input dataset to the mainframe using the following command, enter your username when 
the command prompt asks:

        npm run uploadFile
        
3. Navigate to the **test4z/src/test/doggos/doggos.test.ts** file back, and run it using the following command:

        npm run test
        
4. Observe the failed test cases, update them according to your changes in the DOGGOS.INPUT file (frim the 1st step). 
If you added a new breed, create a test suite for it by following the existing breed test cases.
5. Run the test suite again, and verify all the test cases are passing.

        npm run test
