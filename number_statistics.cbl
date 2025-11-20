       IDENTIFICATION DIVISION.
       PROGRAM-ID. number_statistics.
       
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUMBERS-TABLE. *> array to hold numbers (10 elements)
           05  NUMBERS-ELEM OCCURS 10 TIMES PIC 9(4) VALUE ZEROS. *> each number
       01  TOTAL        PIC 9(6) VALUE ZEROS.
       01  AVERAGE      PIC 9(6)V99 VALUE ZEROS. *> v99 for decimal places
       01  MAXIMUM      PIC 9(4) VALUE ZEROS.
       01  MINIMUM      PIC 9(4) VALUE 9999. 
       *> we put a high initial value to ensure any input number is lower
       01  I            PIC 9(2) VALUE ZEROS. *> loop index
       PROCEDURE DIVISION.
           *> loop to accept 10 numbers and compare for max and min
           *> populate total as well
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
               DISPLAY "Enter number " I ": "
               ACCEPT NUMBERS-ELEM(I)
               ADD NUMBERS-ELEM(I) TO TOTAL
               IF NUMBERS-ELEM(I) > MAXIMUM
                   MOVE NUMBERS-ELEM(I) TO MAXIMUM
               END-IF
               IF NUMBERS-ELEM(I) < MINIMUM
                   MOVE NUMBERS-ELEM(I) TO MINIMUM
               END-IF
           END-PERFORM
           
           COMPUTE AVERAGE = TOTAL / 10
           
           DISPLAY "Total: " TOTAL
           DISPLAY "Average: " AVERAGE
           DISPLAY "Maximum: " MAXIMUM
           DISPLAY "Minimum: " MINIMUM
           
           STOP RUN.
       
       END PROGRAM number_statistics.
