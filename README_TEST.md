# Test Challenge

The activities in this test challenge are:

1. *Generate Test Coverage Report:* Running tests and generating a report to visualize code coverage.
2. *Edit a Test Case:* Modifying a specific test case to change expected outcomes and observing the results.
3. *Add a Test4z Statement to a Test File:* Inserting a Test4z statement into the test code to demonstrate how to use Test4z snippets.

## Getting Started

1. Login to the workshop system using the given URL, username, and password, and follow the steps your instructor provides

<img src='images/cloudAccess.png' width='15%'> → <img src='images/workshopStage.png' width='50%'> → <img src='images/workspaceStart.png' width='25%'>

2. You are in the secure cloud environment which runs VS Code and is connected to the Mainframe
3. Make sure the initial build process has been completed successfully (**exit code: 0** message in the active terminal)
4. Close the terminal from it's right top corner

## Generate Test Coverage Report

Press `cmd+shift+P` (MacOS) / `ctrl+shift+L` (Windows). Enter “Test4z Run All Tests with Coverage” like on the following screenshot:

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
           MOVE <b>009</b> TO EXPECTED_ADOPTIONS(1).
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
