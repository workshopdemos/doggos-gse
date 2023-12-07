//<LSTPRF> JOB ACCT#,REGION=0M,CLASS=A                                  00010001
//RPT     EXEC PGM=IN25UTIL,REGION=2M                                   00020000
//STEPLIB   DD DISP=SHR,DSN=PRODUCT.INTERTST.LOADLIB                    00130000
//          DD DISP=SHR,DSN=PRODUCT.INTERTST.R11J.CAVHLOAD              00140000
//          DD DISP=SHR,DSN=PRODUCT.INTERTST.CAVHLOAD                   00150000
//PROTSYM   DD DISP=SHR,DSN=&SYSUID..PUBLIC.PROTSYM                     00151000
//OUTPUT    DD SYSOUT=*,DCB=(LRECL=133,BLKSIZE=3990)                    00152000
//MESSAGE   DD SYSOUT=*                                                 00153000
//CARDS     DD *                                                        00154000
REPORT                                                                  00155000
/*                                                                      00156000
