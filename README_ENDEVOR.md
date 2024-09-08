# Code/Build/Debug Challenge
# Main Scenario
## Getting Started

1. Login to the workshop system using the given URL, username, and password, and follow the steps your instructor provides

<img src='images/cloudAccess.png' width='15%'> → <img src='images/workshopStage.png' width='50%'> → <img src='images/workspaceStart.png' width='25%'>

2. You are in the secure cloud environment which runs VSCode and is connected to the Mainframe
3. Make sure the initial build process has been completed successfully (**exit code: 0** message in the active terminal)
4. Close the terminal from it's right top corner

## Get familiar with the VSCode Activity Bar
<img src='images/activityBar.png' width='50%'>

## Run the DOGGOS application
1. Go to Zowe Explorer (Z icon in the VSCode Activity Bar)
2. Hover the “zosmf” item in the DATA SET section in the sidebar and click on the magnifier icon. Enter CUST0xy in the search field and hit enter. Note that CUST0xy is the mainframe user id that is shared by your instructor
3. Fill in the data set: CUST0xy.PUBLIC to add all data sets with this prefix to Zowe Explorer (Use your userID number instead of CUST0xy) 
4. Expand the CUST0xy.PUBLIC.JCL data set and right-click on the RUNDOG
5. Select “Submit Job” menu item, then click "Submit" from the pop-up window 
6. Click on the JOB number in the pop-up message in the right bottom corner to see the JOB output (if the notification disappears, you can hit the bell icon from the bottom-right corner to see)
7. Expand the “RUNDOG(JOBxxxxx)” and click on the RUN:OUTREP item to browse the program output (Repeat the 6th step if you cannot expand the job output)
8. Breeds not specified in the COBOL code, fall into the OTHER section in the execution report. Now, your task is to add one more breed to the program to result in printing it in this report

## Get DOGGOS application from the PROD environment

1. Go to Explorer for Endevor extension from the Activity Bar
2. Wait for the initializing process to be completed
3. Expand **endevor** and **endevor-location** wait for fetching the elements (connection and location settings have already been pre-configured prior the workshop)
4. Fetching the elements will result in a warning due to your empty dev sandbox
5. Enable elements from the prod environment by using Element Search Mode Selector (components icon)

![Search Mode Selector Icon](images/endevor/end10a.png)

6. Select **Only First Found Elements** mode to make the prod environment elements from up the map to appear in the view

![First Found Search Mode](images/endevor/end10b.png)

7. Now you have all of the DOGGOS applications in your cloud VSCode IDE
8. Find the COBOL code associated with your user under the [MAP] folder by expanding as shown below
9. Right-click, select edit, and start coding to add a new dog breed

![Edit](images/endevor/end11.png)

## Edit&Build the DOGGOS application

1. Copy block of code (lines 59-61)
2. Paste it after line 61 (You can use CTRL+G to jump into the given line number)
3. Change JINGO to another dog breed name (e. g. **HUSKY**) in the whole pasted block of code
4. For HUSKY-INDEX-VALUE change VALUE to 9  (line 63)
5. For OTHER-INDEX-VALUE change VALUE to 10 (line 66)
6. Change PIC 9(1) to PIC 9(2) for OTHER-INDEX-VALUE (line 66)
7. Change OCCURS value to 10 (line 71)
8. Copy block of code (lines 208-210)
9. Paste it after line 210
10. Change JINGO to the dog breed name you picked in step 3 (**HUSKY**) within the pasted block of code
11. Copy block of code (lines 139-142)
12. Paste it after line 142
13. Change JINGO to the dog breed name you picked in step 3 (**HUSKY**) within the pasted block of code
14. Use CTRL+S (or COMMAND+S) to save the changes and bring the file to your sandbox
15. A prompt will ask for the Endevor path to upload the COBOL element. Hit enter to approve the pre-filled value

<img src='images/endevor/end-preDefined.png' width='55%'>

16. Add your mainframe username as CCID, and add a change comment (e.g 'new breed added').
17. Select **Yes** from the list to generate the object modules

<img src='images/endevor/end-autoGen.png' width='55%'>

18. Wait for upload&fetch elements

## Link the DOGGOS application

1. Expand the LNK folder, find the element associated with your user under the [MAP] folder, right click and select edit

![Expand](images/endevor/end16.png)

2. Without any edit, use CTRL+S (or COMMAND+S) to bring the file to your sandbox
3. A prompt will ask for the Endevor path to upload the link element. Hit enter to approve the pre-filled value
4. Add your mainframe username as CCID, and add a comment (e.g 'bring link element').
5. Select **Yes** from the list to generate the load modules

<img src='images/endevor/end-autoGen.png' width='55%'>

6. Wait for upload&fetching elements
7. Collapse the [MAP] folders to see your edited LINK element
8. At this step your Explorer for Endevor tab would look like the following:

![Overview](images/endevor/end17.png)

## Run the DOGGOS application AFTER the change is made

1. Go to Zowe Explorer (Z icon in the VSCode Activity Bar)
2. Hover the “zosmf” item in the DATA SET section in the sidebar and click on the magnifier icon. Enter CUST0xy in the search field and hit enter. Note that CUST0xy is the mainframe user id that is shared by your instructor. 
3. Click on the CUST0xy.PUBLIC.INPUT data set  to edit it
4. Add the following line with the name of the dog breed you chose in the code change (**HUSKY**)

<img src='images/image06.png' width='50%'>

   Please note to enter two records for HUSKY as listed in above screenshot. 

5. Use CTRL+S (or COMMAND+S) to save the change
6. Expand the CUST0xy.PUBLIC.JCL data set and right click on the **NDRUNDOG**
7. Select “Submit Job” menu item, then click "Submit" from the pop-up window
8. Click on the JOB number in the pop up message in the right bottom corner to see the JOB output
9. Expand the “NDRUNDOG(JOBxxxxx)” and click on the RUN:OUTREP item to browse the program output (Repeat 8th step if you cannot expand the job output)

The new dog breed “HUSKY” is listed and the counter reports 11 adopted HUSKY dogs. 🎉

## Debug

1. Let’s introduce a bug in the program data 🙂 Go to the input file again and change the breed from “JINGO” to “JINGA”.
2. Use CTRL+S (or COMMAND+S) to save the change
3. Rerun the application repeating the steps in the previous section (from 6th step) 
4. Open the output file and see that report is wrong, it now contains 0 for JINGO and 6 for the OTHER
5. Let’s debug the program
6. Go to debugger extension by clicking the play icon with a bug <img src='images/image22.png' width='4%'> shortcut: CTRL+SHIFT+D (or COMMAND+SHIFT+D)
7. We already have the debugging session preconfigured for DOGGOS application, make sure you choose the one for Endevor from the dropdown

<img src='images/endevor/end20.png' width='35%'>

8. Click the play button to start the debugging

<img src='images/image10.png' width='50%'>

9. You will be asked for your Mainframe password. It is the same as your  mainframe userID. Now the debugger will fetch the extended source and start the session.
10. Now where to put a breakpoint?
11. The report for JINGO breed was wrong, so let’s put a breakpoint where the value is updated. Let’s find the first place in the code by searching for JINGO with Ctrl+F (CMD+F on Mac).
12. We can see that processing for JINGO breed is handled by these variables.
13. Let’s find all instances where JINGO-BREED-NAME by right-clicking on it, and selecting Peek → Peek references. Go through the references to find where the amount is updated. It will be here around line 238 in extended source:

![Peek](images/image11.png)

14. Double-click on the 238 line in the editor window to move there.
15. Now let’s add a breakpoint after this condition to see if we get there.
Click on the left area on line 239. The red dot will appear

<img src='images/image12.png' width='65%'>

16. The value for OTHER breeds was wrong in the repo. Let’s put there a breakpoint as well
That would be on line 245

<img src='images/image13.png' width='65%'>

17. We now have 2 breakpoints (you can see them in breakpoints section in the bottom left corner):

<img src='images/image14.png' width='30%'>

18. Now let’s continue the execution by clicking the play button on the left of the debug toolbar (or F5):

<img src='images/image23.png' width='30%'>

19. We can see that while looping through the breeds the debugger skipped the breakpoint on line 239 and stopped at line 245

<img src='images/image16.png' width='65%'>

20. Let’s check the variables. Click on the INP-ADOPTED-AMOUNT variable, right-click, and “Add to watch”
21. Do the same for the INP-DOG-BREED variable on line 216 to understand which breed we are analyzing
22. You can see in your watch section the value of the variables (BTW, a quick way is just to hover over a variable name in your extended source and the value will pop up)

<img src='images/image18.png' width='40%'>

23. As you can see we have encountered a wrong breed name “JINGA”, which means that our input file is corrupted! We also never entered a section for the JINGO breed, which means we never actually encountered this breed while parsing.
24. Now we found our problem - wrong breed in the input file :)
25. Stop the debug session by clicking the stop icon from the debugging toolbar.

![Value](images/image20.png)


# Test Challenge

The activities in this test challenge are:

1. *Generate Test Coverage Report:* Running tests and generating a report to visualize code coverage.
2. *Edit a Test Case:* Modifying a specific test case to change expected outcomes and observing the results.
3. *Add a Test4z Statement to a Test File:* Inserting a Test4z statement into the test code to demonstrate how to use Test4z snippets.

## Generate Test Coverage Report

From the Cloude IDE Window, Select the HamBurger icon on the top left (three horizontal lines) and then 
Select View and Command Palette. Reference screenshot: 

<img src='images/test4z/image_command_palette.png' width='65%'>

Enter “Test4z Run All Tests with Coverage” like on the following screenshot:

<img src='images/test4z/image_command_palette_run_all_tests_cov.png' width='65%'>

This will run the tests and generate the report.

<img src='images/test4z/image_coverage_report.png' width='85%'>

The Code Coverage dashboard will be opened automatically:

<img src='images/test4z/image_report_all_files.png' width='85%'>

To see the statement-level code coverage, click on the `DOGGOS.cbl` file in the report:

<img src='images/test4z/image_statement_level_coverage.png' width='85%'>

## Edit a Test Case

Open the [`TDOGGOS.cbl`](DOGGOS/COBTEST/TDOGGOS.cbl#L266) file under `DOGGOS`/`COBTEST` folder and edit the test case.

Find `MOVE 008 TO EXPECTED_ADOPTIONS(1).` and change it to `MOVE 009 TO EXPECTED_ADOPTIONS(1).`.

Code after change:

<pre>
       DEFINE_EXPECTED_DATA.
           MOVE <b>009</b> TO EXPECTED_ADOPTIONS(1).
           MOVE 000 TO EXPECTED_ADOPTIONS(2).
</pre>

From the command line, run the `t4z` command.

Expected output:

```
 FAIL  DOGGOS/COBTEST/TDOGGOS.cbl
  ✓ DOGGOS simple run (123 ms)
  ✕ DOGGOS validate accumulator (436 ms)
      Assertion error: Invalid accumulator value
      SYSOUT:
      THIS PROGRAM WILL CALCULATE AMOUNT OF ADOPTED DOGGOS PER SOME PERIODS OF TIME
      TODAY IS :2024
      Mismatch for index 0000000001
      Actual 008
      Expected 009
  ✓ DOGGOS force open error (141 ms)
  ✓ DOGGOS force read error (570 ms)

Tests Suites: 1 failed, 1 total
Tests:        1 failed, 3 passed, 4 total
Time:         1 s
```

You will observe that the test run is a failure. The actual value is `008` but we have the expected value to be `009`.

Before continuing, revert the change back to:
<pre>
           MOVE <b>008</b> TO EXPECTED_ADOPTIONS(1).
</pre>

## Add a Test4z Statement to the Test File

Open the [`TDOGGOS.cbl`](DOGGOS/COBTEST/TDOGGOS.cbl#L136) file under `DOGGOS`/`COBTEST` folder and edit the test case.

Find `Implementation for TEST1`. That will get you to this code:

<pre>
      ********************************************************
      * Implementation for TEST1
      ********************************************************
           ENTRY 'TEST1'
           <small><i>(Place your cursor here)</i></small>
      *    Mock all external resources
           PERFORM MOCK_ADOPTS_FILE
</pre>

Add a new line after `ENTRY 'TEST1'`.
Move the cursor the start of Area B (column 12) and type `t4z me`.
The IntelliSense will offer you possible code completions using the Test4z snippets as you can see in the screenshot:

<img src='images/test4z/image_test1.png' width='65%'>

Select “t4z Message write”.

This will fill in the code for you:

<img src='images/test4z/image_code_snippet.png' width='65%'>

Replace `'Your Message'` with `'Hello Test4z!'` and save the file with code like that:

<pre>
           ENTRY 'TEST1'
           move low-values to I_Message in ZWS_Message
           move '<b>Hello Test4z!</b>' to messageText in ZWS_Message
           call ZTESTUT using ZWS_Message
</pre>

From the command line, run `t4z`. The expected output is:

<pre>
❯ t4z

 PASS  DOGGOS/COBTEST/TDOGGOS.cbl
  ✓ DOGGOS simple run (110 ms)
      <b>Hello Test4z!</b>
  ✓ DOGGOS validate accumulator (500 ms)
  ✓ DOGGOS force open error (410 ms)
  ✓ DOGGOS force read error (680 ms)

Tests Suites: 1 passed, 1 total
Tests:        4 passed, 4 total
Time:         2 s
</pre>

## Summary

This demo scenario demonstrates how to generate a test coverage report, edit a test case, and add Test4z statements to a test file.
