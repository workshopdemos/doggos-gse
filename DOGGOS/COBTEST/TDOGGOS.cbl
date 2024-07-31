       PROCESS PGMN(LM),NODYNAM
      ******************************************************************
      * The above process option is required for long entry point
      * names and locating the entry points. These options should not
      * be changed.
      ******************************************************************
      ******************************************************************
      * This test suite contains a set of tests meant to show how the
      * Test4z API can be used. It is not meant to be exhaustive
      * but instead show patterns of usage and code organization.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'TDOGGOS' RECURSIVE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      * Copy in our required control blocks from Test4z.
      ******************************************************************
       COPY ZTESTWS.

      ******************************************************************
      * Define any working-storage items that we need.
      ******************************************************************

      * Test4z File object that will contain ADOPT input records
       1 ADOPTS_FILE.
         COPY ZFILE.

      * Input data used to initialize above file.
       1 ADOPT_INPUT.
         3 MY_DATA.
           5 FILLER.
               7 PIC X(30) VALUE 'SHIBA'.
               7 PIC X(25) VALUE SPACES.
               7 PIC X(3)  VALUE '006'.
           5 FILLER.
               7 PIC X(30) VALUE 'KORGI'.
               7 PIC X(25) VALUE SPACES.
               7 PIC X(3)  VALUE '007'.
           5 FILLER.
               7 PIC X(30) VALUE 'CHI'.
               7 PIC X(25) VALUE SPACES.
               7 PIC X(3)  VALUE '001'.
           5 FILLER.
               7 PIC X(30) VALUE 'SHIBA'.
               7 PIC X(25) VALUE SPACES.
               7 PIC X(3)  VALUE '002'.
           5 FILLER.
               7 PIC X(30) VALUE 'JINGO'.
               7 PIC X(25) VALUE SPACES.
               7 PIC X(3)  VALUE '006'.

      * Test4z QSAM file access mock object for ADOPTS DD.
      * Used to access ADOPTS_FILE records.
       1 ADOPTS.
         COPY ZQSAM.

      * Test4z QSAM file access mock object for OUTREP DD.
      * Only used for output so no need to separately create
      * file with input records - the file written to is created
      * automatically.
       1 OUTREP.
         COPY ZQSAM.

      * Variable given on registration of 'FORCE_ERROR_SPY' callback.
       1 IO_COMMAND PIC X(10).

      * Loop counter
       1 I PIC 9(9) COMP-5.

      * List ptr for looping through lists
      * record_int allows for pointer arithmetic
       1 RECORD_PTR USAGE POINTER.
       1 RECORD_INT REDEFINES RECORD_PTR PIC S9(9) COMP-5.

       1 EXPECTED_ACCUMULATOR.
           05 EXPECTED_ADOPTIONS PIC 9(3) OCCURS 9 TIMES.

       LINKAGE SECTION.
      * Copy in our required control blocks from Test4z.
       COPY ZTESTLS.

      * Report record used when accessing records written to OUTREP
       COPY ADOPTRPT.

      * Used in 'FORCE_ERROR_SPY' callback implementation to map
      * the given IO_COMMAND variable setup
       1 SPY_IO_COMMAND PIC X(10).

      * Mapping of above pointer.  Used to validate values within
      * the ACCUMULATOR DOGGOS program variable at the time the
      * given spy callback is invoked.
       1 SPY_ACCUMULATOR.
           05 ADOPTIONS PIC 9(3) OCCURS 9 TIMES.

       1 MY_CODE PIC X(2).

       PROCEDURE DIVISION.
      ******************************************************************
      * Register a set of tests to be run.
      * Each I_Test invocation registers a name and test
      * implementation to be executed.
      * The given name for each test will be reported with a PASS/FAIL
      ******************************************************************
           MOVE LOW-VALUES TO I_TEST
           SET TESTFUNCTION IN ZWS_TEST TO ENTRY 'TEST1'
           MOVE 'DOGGOS simple run' TO TESTNAME IN ZWS_TEST
           CALL ZTESTUT USING ZWS_TEST

           MOVE LOW-VALUES TO I_TEST
           SET TESTFUNCTION IN ZWS_TEST TO ENTRY 'TEST2'
           MOVE 'DOGGOS validate accumulator' TO TESTNAME IN ZWS_TEST
           CALL ZTESTUT USING ZWS_TEST

           MOVE LOW-VALUES TO I_TEST
           SET TESTFUNCTION IN ZWS_TEST TO ENTRY 'TEST3'
           MOVE 'DOGGOS force open error' TO TESTNAME IN ZWS_TEST
           CALL ZTESTUT USING ZWS_TEST

           MOVE LOW-VALUES TO I_TEST
           SET TESTFUNCTION IN ZWS_TEST TO ENTRY 'TEST4'
           MOVE 'DOGGOS force read error' TO TESTNAME IN ZWS_TEST
           CALL ZTESTUT USING ZWS_TEST

      ******************************************************************
      * Define the expected data
      ******************************************************************
           PERFORM DEFINE_EXPECTED_DATA

           GOBACK.

      ******************************************************************
      * Implementation for TEST1
      ******************************************************************
           ENTRY 'TEST1'
      *    Mock all external resources
           PERFORM MOCK_ADOPTS_FILE
           PERFORM MOCK_OUTREP_FILE
      *    Prepare and execute the DOGGOS program under test
           PERFORM RUN_DOGGOS
      *    Print the results written to the OUTREP file
           PERFORM PRINT_REPORT
           GOBACK.

      ******************************************************************
      * Implementation for TEST2
      ******************************************************************
           ENTRY 'TEST2'
           PERFORM MOCK_ADOPTS_FILE
           PERFORM MOCK_OUTREP_FILE
      * Register the CHECK_ACCUMULATOR_SPY callback which will
      * validate that all the values in the ACCUMULATOR DOGGOS
      * program variable are correct.
           PERFORM REGISTER_CHECK_ACCUMULATOR_SPY
           PERFORM RUN_DOGGOS
           GOBACK.

      ******************************************************************
      * Spy callback implementation for checking values in accumulator
      * The callback is registered by the REGISTER_CHECK_ACCUMULATOR_SPY
      * call seen above.
      ******************************************************************
           ENTRY 'CHECK_ACCUMULATOR_SPY' USING
               ZLS_GOBLOCK, ZLS_Q_ITBLOCK, ZLS_Q_IFBLOCK

      *    A spy callback is called 4 times for each operation:
      *     - WHEN_BEFORE & SPY_BEFORE
      *     - WHEN_BEFORE & SPY_AFTER
      *     - WHEN_AFTER & SPY_BEFORE
      *     - WHEN_AFTER & SPY_AFTER
      *    Only process the last time for this callback
           IF WHEN_AFTER IN ZLS_Q_ITBLOCK AND SPY_AFTER IN ZLS_Q_ITBLOCK
              IF COMMANDNAME IN ZLS_Q_ITBLOCK = 'CLOSE'

      *         Access ACCUMULATOR variable in DOGGOS
      *         which results in the test linkage section variable
      *         SPY_ACCUMULATOR mapped onto the memory of that variable.
                MOVE LOW-VALUES TO I_GETVARIABLE
                MOVE 'ACCUMULATOR' TO VARIABLENAME IN ZWS_GETVARIABLE
                CALL ZTESTUT USING ZWS_GETVARIABLE,
                    ADDRESS OF SPY_ACCUMULATOR

      *         Check accumulator values as assert correct values
      *         The 'FAIL_ACCUMULATOR' will end the test with given
      *         message if the condition is false
                PERFORM VARYING I FROM 1 BY 1 UNTIL I > 9
                     IF ADOPTIONS(I) NOT = EXPECTED_ADOPTIONS(I)
                         DISPLAY 'Mismatch for index ' I
                         DISPLAY 'Actual ' ADOPTIONS(I)
                         DISPLAY 'Expected ' EXPECTED_ADOPTIONS(I)
                         PERFORM FAIL_ACCUMULATOR
                     END-IF
                END-PERFORM
              END-IF
           END-IF
           GOBACK.

      ******************************************************************
      * Implementation for TEST3
      ******************************************************************
           ENTRY 'TEST3'
           PERFORM MOCK_ADOPTS_FILE
           PERFORM MOCK_OUTREP_FILE
           MOVE 'OPEN' TO IO_COMMAND
           PERFORM REGISTER_FORCE_ERROR_SPY
           PERFORM RUN_DOGGOS
           GOBACK.

      ******************************************************************
      * Implementation for TEST4
      ******************************************************************
           ENTRY 'TEST4'
           PERFORM MOCK_ADOPTS_FILE
           PERFORM MOCK_OUTREP_FILE
           MOVE 'READ' TO IO_COMMAND
           PERFORM REGISTER_FORCE_ERROR_SPY
           PERFORM RUN_DOGGOS
           GOBACK.

      ******************************************************************
      * Spy callback implementation to force IO error paths.
      * Used by both TEST3 and TEST4. The registration of this
      * callback is done by PERFORM of 'REGISTER_FORCE_ERROR_SPY' proc
      * in each of these tests.
      * Note the SPY_IO_COMMAND parameter which is the IO_COMMAND value
      * initially set up when this spy was registered
      ******************************************************************
           ENTRY 'FORCE_ERROR_SPY' USING
               ZLS_GOBLOCK, ZLS_Q_ITBLOCK, ZLS_Q_IFBLOCK,
               SPY_IO_COMMAND

      *    A spy callback is called 4 times for each operation:
      *     - WHEN_BEFORE & SPY_BEFORE
      *     - WHEN_BEFORE & SPY_AFTER
      *     - WHEN_AFTER & SPY_BEFORE
      *     - WHEN_AFTER & SPY_AFTER
      *    Only process the last time for this callback
           IF WHEN_AFTER IN ZLS_Q_ITBLOCK AND SPY_AFTER IN ZLS_Q_ITBLOCK
      *       Map the linkage section to the address of the last record.
              SET ADDRESS OF MY_CODE TO STATUSCODE IN ZLS_Q_IFBLOCK

      *       Check if the command that caused this callback to be
      *       invoked is the one we want to process on.
              IF COMMANDNAME IN ZLS_Q_ITBLOCK(1:4) = 'OPEN'
                 AND SPY_IO_COMMAND = 'OPEN'
                 MOVE '35' TO MY_CODE
              ELSE
                 IF COMMANDNAME IN ZLS_Q_ITBLOCK(1:4) = 'READ'
                    AND SPY_IO_COMMAND = 'READ'
      *             Set error code on 5th READ
                    IF (ITERATION IN ZLS_Q_ITBLOCK = 5)
                       MOVE '46' TO MY_CODE
                    END-IF
                 END-IF
               END-IF
            END-IF
           GOBACK.

      ******************************************************************
      * Expected values ACCUMULATOR values
      ******************************************************************
       DEFINE_EXPECTED_DATA.
           MOVE 008 TO EXPECTED_ADOPTIONS(1).
           MOVE 000 TO EXPECTED_ADOPTIONS(2).
           MOVE 007 TO EXPECTED_ADOPTIONS(3).
           MOVE 001 TO EXPECTED_ADOPTIONS(4).
           MOVE 000 TO EXPECTED_ADOPTIONS(5).
           MOVE 000 TO EXPECTED_ADOPTIONS(6).
           MOVE 000 TO EXPECTED_ADOPTIONS(7).
           MOVE 006 TO EXPECTED_ADOPTIONS(8).
           MOVE 000 TO EXPECTED_ADOPTIONS(9).

      ******************************************************************
      * Common proc to handle failed assertions about ACCUMULATOR values
      ******************************************************************
       FAIL_ACCUMULATOR.
           MOVE LOW-VALUES TO I_FAIL IN ZWS_FAIL
           MOVE 'Invalid accumulator value' TO FAILMESSAGE IN ZWS_FAIL
           CALL ZTESTUT USING ZWS_FAIL.

      ******************************************************************
      * Common proc to run DOGGOS program
      ******************************************************************
       RUN_DOGGOS.
           MOVE LOW-VALUES TO I_RUNFUNCTION
           MOVE 'DOGGOS' TO MODULENAME IN ZWS_RUNFUNCTION
           CALL ZTESTUT USING ZWS_RUNFUNCTION.

      ******************************************************************
      * Common proc to mock ADOPTS file
      ******************************************************************
       MOCK_ADOPTS_FILE.

      * Create a base file object containing ADOPTS input records.
           MOVE LOW-VALUES TO I_FILE
           SET RECORDADDRESS IN ZWS_FILE TO ADDRESS OF ADOPT_INPUT
           MOVE 5 TO RECORDCOUNT IN ZWS_FILE
           MOVE 58 TO RECORDSIZE IN ZWS_FILE
           CALL ZTESTUT USING ZWS_FILE, FILEOBJECT IN ADOPTS_FILE

      * Initialize QSAM file access mock object for the ADOPTS DD
      * with the file object created above.
           MOVE LOW-VALUES TO I_MOCKQSAM
           MOVE 'ADOPTS' TO FILENAME IN ZWS_MOCKQSAM
           SET FILEOBJECT IN ZWS_MOCKQSAM TO
               ADDRESS OF FILEOBJECT IN ADOPTS_FILE
           CALL ZTESTUT USING ZWS_MOCKQSAM, QSAMOBJECT IN ADOPTS.

      ******************************************************************
      * Common proc to mock OUTREP QSAM output file.
      ******************************************************************
       MOCK_OUTREP_FILE.
           MOVE LOW-VALUES TO I_MOCKQSAM
           MOVE 'OUTREP' TO FILENAME IN ZWS_MOCKQSAM
           MOVE 58 TO RECORDSIZE IN ZWS_MOCKQSAM
           CALL ZTESTUT USING ZWS_MOCKQSAM, QSAMOBJECT IN OUTREP.

      ******************************************************************
      * Common proc to display contents of OUTREP file
      ******************************************************************
       PRINT_REPORT.
      *    set the address of our record pointer to
      *    the root address of our records in OUPREP file
           SET RECORD_PTR TO PTR IN RECORDS_ IN FILE_ IN OUTREP

      *    loop thru all the records and display each one
           PERFORM VARYING I FROM 1 BY 1 UNTIL
           NOT (I<=SIZE_ IN RECORDS_ IN ADOPTS_FILE)
              SET ADDRESS OF ADOPTED-REPORT-REC TO RECORD_PTR
              DISPLAY ADOPTED-REPORT-REC

      *       Compute the next record pointer by adding the
      *       record stride (length) to the current record ptr
              ADD STRIDE IN RECORDS_ IN ADOPTS_FILE TO RECORD_INT
           END-PERFORM.

      ******************************************************************
      * Register proc for 'FORCE_ERROR_SPY' callback on the ADOPTS DD.
      ******************************************************************
       REGISTER_CHECK_ACCUMULATOR_SPY.
           MOVE LOW-VALUES TO I_LLREGISTERSPY
           MOVE 'DOGGOS' TO MODULENAME IN ZWS_LLREGISTERSPY
           MOVE 'ADOPTS' TO ARTIFACTNAME IN ZWS_LLREGISTERSPY
           SET INTERFACETYPEQSAM IN ZWS_LLREGISTERSPY TO TRUE
           SET HANDLER IN ZWS_LLREGISTERSPY
               TO ENTRY 'CHECK_ACCUMULATOR_SPY'
           CALL ZTESTUT USING ZWS_LLREGISTERSPY.

      ******************************************************************
      * Register proc for 'FORCE_ERROR_SPY' callback on the ADOPTS DD.
      * Used by both TEST3 and TEST4. Note the IO_COMMAND
      * variable given as part of the registration.  Every
      * invocation of the callback will pass along the address
      * of this variable.  The callback implementation can then
      * use this data for whatever purpose it wants.
      * In this usage the operation to force the
      * error upon (READ/OPEN) is setup by each test.
      ******************************************************************
       REGISTER_FORCE_ERROR_SPY.
           MOVE LOW-VALUES TO I_LLREGISTERSPY
           MOVE 'DOGGOS' TO MODULENAME IN ZWS_LLREGISTERSPY
           MOVE 'ADOPTS' TO ARTIFACTNAME IN ZWS_LLREGISTERSPY
           SET INTERFACETYPEQSAM IN ZWS_LLREGISTERSPY TO TRUE
           SET HANDLER IN ZWS_LLREGISTERSPY
               TO ENTRY 'FORCE_ERROR_SPY'
           SET USERDATA IN ZWS_LLREGISTERSPY TO
               ADDRESS OF IO_COMMAND
           CALL ZTESTUT USING ZWS_LLREGISTERSPY.

       END PROGRAM 'TDOGGOS'.
