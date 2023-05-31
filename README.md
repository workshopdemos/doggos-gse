# Getting Started


1. You are in the secure cloud environment which runs VS Code and is connected to the Mainframe
2. Install Code4z VSCode extension pack:
- Go to VS Code marketplace by clicking this icon images/image1.png 
- Search for Code4z and install images/image2.png
- Return to your local files by clicking on the Explorer icon images/image3.png


### How to execute VSCode tasks

- Issue the CTRL+SHIFT+P/CMD+SHIFT+P to open a VSCode Command Palette.
- Choose the `Tasks: Run task` option from the list.
- Use the tasks starting with the `DOGGOS` prefix.

### Repository structure

- The source code lives in the [GSECONF/DOGGOS folder](./GSECONF/DOGGOS).
- The tests live in the [test/doggos folder](./test/doggos/).

### Building (generating or compiling) the program

Please, use the Endevor Bridge for Git Zowe CLI plugin for this purpose. It will get your source code from the GSECONF/DOGGOS folder and build it in the isolated environment on the mainframe. Everything will be cleaned up automatically afterwards, the other developers won't be affected.

**Note: There is already a backend setup for the build on the mainframe side.**

- You need to use the [VSCode task](#how-to-execute-vscode-tasks): `DOGGOS: create endevor service profile` first, to create an Endevor service profile. **Note: this profile helps us to connect to the Endevor backend environment. You only need to run this task once, the profile will be saved in the file system.**
- You can use the [VSCode task](#how-to-execute-vscode-tasks): `DOGGOS: build the source code` to build the source code.
- Review the task output and the listings in the output directory.

**Note: the building process may end up with no generation. It means that there were no changes in the source code, in that case, try to add some comment into it and rebuild it, just to trigger the build.**

### Run the program manually

Please, use Zowe Explorer VSCode extension for this purpose.

**Note: There is already a backend setup for the run on the mainframe side.**

- Build the program source code successfully using the guide above.
- Open Zowe VSCode extension interface: reveal the left column of the VSCode interface and find the big and bold letter Z in there.
- ![Zowe-Explorer](images/zowe-explorer.png)
- Search for the datasets in the lpar1.zosmf Data Sets profile folder.
  - Navigate to the lpar1.zosmf node and click into it.
  - ![Zowe-Explorer-Search](images/zowe-explorer-search.png)
  - Please, use `<USERID>.DOGGOS.*` pattern to search for the datasets.
- Expand the `<USERID>.DOGGOS.JCL` dataset and Right click on the `RUNDOGS` item.
  - Select `Submit JCL` option.
  - ![Zowe-Explorer-Submit](images/zowe-explorer-submit.png)
  - Click into the JobID item in the left bottom corner in the pop notification to see the job results.
    - You can click on the job item several times, until the job will be completed.
    - ![Zowe-Explorer-Job-Submitted](images/zowe-explorer-job-submitted.png)

**Note: If you want to run the updated source code, please, rebuild the program using the guide above and submit the JCL again.**

### Run automated tests for the program

Please, use Jest VSCode extension for this purpose.

**Note: There is already a backend setup for the tests on the mainframe side.**

- Build the program source code successfully using the guide above.
- Open the [test file](/test/doggos/doggos.test.ts) in the VSCode editor and review the test cases if needed.
- Run the tests using the [VSCode task](#how-to-execute-vscode-tasks): `DOGGOS: run tests`.

### Update the test input

**Note: There is already a backend setup for the tests on the mainframe side.**

- Modify [the test input file](/scripts/files/DOGGOS.INPUT).
- Run the [VSCode task](#how-to-execute-vscode-tasks): `DOGGOS: upload file` to upload the newer version and test the source code with it.

### Debugging the program

Please, use Debugger for Mainframe VSCode extension for this purpose.

**Note: There is already a backend setup for the debug on the mainframe side.**

- Build the program source code successfully using the guide above.
- Run the [VSCode task](#how-to-execute-vscode-tasks): `DOGGOS: Update Debugger UserID`.
- Press F5 to start the debugger session.
- Enter the mainframe password for your username in the popup window.
- Wait a bit for the debugger to be executed and follow the program flow using this [guide](https://marketplace.visualstudio.com/items?itemName=broadcomMFD.debugger-for-mainframe).

