//<DBGDOG> JOB ACCT#,REGION=0M,CLASS=A                                  00010000
//RUNPGM   EXEC PGM=CAMRBL01                                            00020000
//* --------- INTERTEST DATA DEFINITIONS                                00021004
//INT1OPTS DD *                                                         00030000
  EXEC=<NDDBGDOG>  ,PROFILE=<USERN>                                       00040000
/*                                                                      00050000
//INT1PARM DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHSAMP               00060000
//INT1LOAD DD DISP=SHR,DSN=PRODUCT.INTERTST.LOADLIB                     00070000
//         DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHLOAD               00080000
//INT1PNLL DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHPNL1               00090000
//INT1MSGL DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHMSG0               00100000
//INT1PROF DD DISP=SHR,DSN=<USERN>.PUBLIC.PROFLIB                       00110000
//STEPLIB  DD DISP=SHR,DSN=<USERN>.PUBLIC.LOADLIB                       00120000
//         DD DISP=SHR,DSN=PRODUCT.INTERTST.LOADLIB                     00130000
//         DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHLOAD               00140000
//         DD DISP=SHR,DSN=PRODUCT.INTERTST.CAVHLOAD                    00150002
//* --------- DOGGOS DATA DEFINITIONS                                   00150204
//ADOPTS   DD DISP=SHR,DSN=&SYSUID..PUBLIC.INPUT                        00151002
//OUTREP   DD SYSOUT=*                                                  00152004
//SYSOUT   DD SYSOUT=*                                                  00170002
