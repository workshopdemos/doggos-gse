      * THE DATA STRUCTURE OF THE RECORD IN THE DOGGOS REPORT                   
       01  ADOPTED-REPORT-REC.                                                  
           05 FILLER                 PIC X(6)                                   
                    VALUE "BREED ".                                             
           05 OUT-DOG-BREED              PIC X(30).                             
           05 FILLER                 PIC X(13)                                  
                    VALUE " WAS ADOPTED ".                                      
           05 OUT-ADOPTED-AMOUNT         PIC 9(3).                              
           05 FILLER                 PIC X(11)                                  
                    VALUE " TIMES PER ".                                        
           05 OUT-REPORT-PERIOD.                                                
               10 OUT-REPORT-TIME        PIC 9(2).                              
               10 FILLER                 PIC X(1) VALUE " ".                    
               10 OUT-PERIOD-NAME        PIC X(10).                             
           05 FILLER                 PIC X(4).                                  
