# **Git-Endevor mapping**

### Overview

This repository was initialized using [CA Endevor Bridge for Git](http://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git.html).
Following branches are synchronized with CA Endevor:

- main

**[Endevor inventory details](./docs/inventory.md)**  
**[Types and processor groups list](./docs/types.md)**

To know more about CA Endevor Bridge for Git and how to use it, check the page [Use the CA Endevor Bridge for Git](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git/use-the-ca-enterprise-git-bridge.html).

### Install Pre-push hook locally

If you do not have the server pre-receive hook enabled, you need to use the local pre-push hook. You can install the hook in one of two ways:

1. Run the script [scripts/setup.sh](scripts/setup.sh).
   <br/>OR
2. Copy manually the [pre-push](scripts/resources/pre-push) script into the hidden `.git/hooks` folder.

### Work Areas

To update information about the Work Areas for this repository, consult the provided [work-areas.json](.ebg/work-areas.json)
template in the [official documentation](http://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git/set-up-and-run-the-ca-endevor-bridge-for-git/optional-configure-and-commit-workareas-file.html).

### Testing

Before you attempt to install the Doggos Regression Test Suite project, ensure you meet the following prerequisites:

- Test4z is deployed, configured and running on your z/OS system.
- Visual Studio Code (VS Code) is installed.
- Node.js is installed.
- Ensure VS Code uses bash to execute shell (.sh) scripts.
- If you have VS Code running, restart it.

### Configuration

Once you have met the prerequisites,

1.  Open a new terminal

2.  Run the following command to install the node dependencies. Test4z configuration and file deployment will be started following the
    dependency installation, enter your username when command prompt asks.

            npm install

### Running The Test Case

1.  Navigate to the **test4z/test/doggos/doggos.test.ts** file and check the regression test codes.
2.  Run the test suite using the following command:

        npm run test

3.  Verify the successful test execution.

### Extending the test suite

1.  Navigate to the **test4z/scripts/files/DOGGOS.INPUT** file. Add a new breed with a number of adoptions, or change
    the number of adoptions for an existing breed.
2.  Upload the new input dataset to the mainframe using the following command, enter your username when
    the command prompt asks:

            npm run uploadFile

3.  Navigate to the **test4z/test/doggos/doggos.test.ts** file back, and run it using the following command:

        npm run test

4.  Observe the failed test cases, update them according to your changes in the DOGGOS.INPUT file (from the 1st step).
    If you added a new breed, create a test suite for it by following the existing breed test cases.
5.  Run the test suite again, and verify all the test cases are passing.

        npm run test
