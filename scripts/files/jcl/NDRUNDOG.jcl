//<RUNDOG>  JOB ACCT#,REGION=0M,CLASS=A                                 00001010
//RUN      EXEC PGM=<NDDBGDOG>                                            00010007
//STEPLIB    DD DISP=SHR,DSN=&SYSUID..PUBLIC.LOADLIB                    00020009
//ADOPTS     DD DISP=SHR,DSN=&SYSUID..PUBLIC.INPUT                      00031011
//OUTREP     DD SYSOUT=*                                                00040007
//SYSOUT     DD SYSOUT=*                                                00050007
