ASMCALLR TITLE 'ASMCALLR'                                               00001000
ASMCALLR AMODE 24
ASMCALLR RMODE 24
ASMCALLR CSECT
         USING ASMCALLR,R12                                             00009000
         USING LDATA,R13                                                00040001
         SPACE ,                                                        00050001
         STM   R14,R12,12(R13)               SAVE THE REGS              00060001
         LR    R12,R15                       ADDRESSABILITY             00070001
         LA    R0,LDATASIZ                   GET LOCAL DATA             00080001
         GETMAIN R,LV=(0)                                               00090001
         XC    0(LDATASIZ,R1),0(R1)          CLEAR IT                   00100001
         ST    R1,8(,R13)                    DOWNLINK                   00110001
         ST    R13,4(,R1)                    UPLINK                     00120001
         LR    R13,R1                        ADDRESS LOCAL DATA         00130001
         SPACE 1                                                        00161000
         WTO   'ENTERING ASMCALLR',ROUTCDE=11                           00248000
*****************************************************
**       SET UP SOME REGS                          **
*****************************************************
         LA    R2,2
         LA    R3,3
         LA    R4,4
         LA    R5,5
         LA    R6,6
         LA    R7,7
         LA    R8,8
         LA    R10,10
         LOAD  EP=COB0C7
         LR    R15,R0
         BALR  R14,R15
         ST    R15,LDRC
RETURN   EQU   *                                                        00249000
         WTO   'LEAVING ASMCALLR',ROUTCDE=11                            00248000
         LA    R0,LDATASIZ                   SIZE OF LOCAL DATA         00280001
         LR    R1,R13                        ADDRESS TO FREE            00290001
         L     R2,LDRC                       KEEP RETURN CODE           00300001
         L     R13,4(,R13)                   UPLINK                     00310001
         FREEMAIN R,LV=(0),A=(1)             FREE LOCAL DATA            00320001
         L     R14,12(,R13)                  GET RETURN ADDRESS         00330001
         LR    R15,R2                        RETURN CODE                00340001
         LM    R0,R12,20(R13)                RESTORE REST OF REGS       00350001
         BR    R14                           RETURN                     00360001
         LTORG ,                                                        00370001
         DROP  R12,R13                                                  00370101
         SPACE ,                                                        00384305
         TITLE 'LOCAL DATA'                                             00384505
         SPACE ,                                                        00385001
LDATA    DSECT                                                          00390001
LDSAVE   DS    18F                                                      00400001
LDRC     DS    F                                                        00410001
LDTIME2  DS    CL16                                                     00411024
LDADR    DS    F                                                        00420020
LDPARM   DS    F                                                        00430020
LDTIME   DS    CL50                                                     00470021
FIELD1   DS    PL2
FILLER   DS    H
FIELD2   DS    PL4
FIELD4   DS    4PL4
LDATASIZ EQU   *-LDATA                                                  00480001
         TITLE 'REGISTER EQUATES'                                       00520001
R0       EQU   0                                                        00530001
R1       EQU   1                                                        00540001
R2       EQU   2                                                        00550001
R3       EQU   3                                                        00560001
R4       EQU   4                                                        00570001
R5       EQU   5                                                        00580001
R6       EQU   6                                                        00590001
R7       EQU   7                                                        00600001
LINKR    EQU   7                                                        00610001
R8       EQU   8                                                        00620001
R9       EQU   9                                                        00630001
R10      EQU   10                                                       00640001
R11      EQU   11                                                       00650001
R12      EQU   12                                                       00660001
R13      EQU   13                                                       00670001
R14      EQU   14                                                       00680001
R15      EQU   15                                                       00690001
         END                                                            00587000
