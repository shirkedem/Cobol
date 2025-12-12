      *> Practice exercise: Create a simple COBOL program for a banking system.
       *> Most comments are notes to self as I learn structure and syntax.
       IDENTIFICATION DIVISION.

       PROGRAM-ID. BANKSYSTEM.

       ENVIRONMENT DIVISION. 
       *> env div links external files and devices to the program.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
         *> file control is a paragraph within io section. 
         *> uses to define external files linked to the program.
           SELECT CUSTOMER-FILE ASSIGN TO "customers.dat".
           SELECT ACCOUNT-FILE ASSIGN TO "accounts.dat".

       DATA DIVISION.
       *> data div is where all data items are defined. 
       *> file section is a paragraph within data division. 
       *> used to define the structure of external files.
         FILE SECTION.
         FD CUSTOMER-FILE.
       01 CUSTOMER-RECORD.
         *> record layout for customer file (id, name, balance).
         *> 01 is level number for top-level record.
         *> 05 is for fields within the record (hierarchy).
          05 CUSTOMER-ID      PIC 9(6).    *> id is numeric, 6 digits.
          05 CUSTOMER-NAME    PIC X(30).   *> name is alphanumeric, 30 chars.

         FD ACCOUNT-FILE.
       01 ACCOUNT-RECORD.
          05 ACCOUNT-NUMBER   PIC 9(10).
          05 ACCOUNT-TYPE     PIC A(10).
          05 ACCOUNT-BALANCE  PIC 9(9)V99.

         *> ws section is for temp data storage during program execution.
         WORKING-STORAGE SECTION.
       01 WS-EXIT-CONDITION   PIC X       VALUE "N".
       01 WS-USER-CHOICE      PIC X.
       01 WS-INPUT-CUST-ID    PIC 9(6).    *> temp storage for input ID
       *> fields used for creating/reading customer records
       01 WS-CUST-ID-TXT      PIC X(6).
       01 WS-CUST-NAME-TXT    PIC X(30).
       01 WS-CUST-BAL-TXT     PIC X(12).      *> store as text like 123.45

       01 WS-SEARCH-ID-TXT    PIC X(6).
       01 WS-FOUND            PIC X       VALUE "N".
       01 WS-EOF              PIC X       VALUE "N".
       01 WS-TEMP             PIC X(100).


       PROCEDURE DIVISION.
       *> procedure div contains the executable code.
       MAIN-LOGIC.
           PERFORM UNTIL WS-EXIT-CONDITION = "Y"
                   DISPLAY " "
                   DISPLAY "-- Welcome to the Banking System --"
                   DISPLAY "1. Create Customer"
                   DISPLAY "2. Open Account for Customer"
                   DISPLAY "3. Exit"
                   DISPLAY "Choose an option: "
                   ACCEPT WS-USER-CHOICE
                   EVALUATE WS-USER-CHOICE
                   WHEN "1"
                        PERFORM CREATE-CUSTOMER
                        *> perform calls a paragraph (like a function)
                   WHEN "2"
                        PERFORM OPEN-ACCOUNT
                   WHEN "3"
                        MOVE "Y" TO WS-EXIT-CONDITION
                        *> use of Y to determine exit condition
                        PERFORM EXIT-MESSAGE
                   WHEN OTHER
                        DISPLAY "Invalid option, try again."
                   END-EVALUATE
           END-PERFORM.
           STOP RUN.
       
       CREATE-CUSTOMER.
           DISPLAY " " 
           DISPLAY "Creating a new customer..."
           DISPLAY "Enter Customer ID (6 digits): "
           ACCEPT WS-INPUT-CUST-ID
           
           *> Validate Customer ID format
           IF WS-INPUT-CUST-ID < 0 OR WS-INPUT-CUST-ID > 999999
              DISPLAY "Invalid Customer ID. Must be 6 digits."
              EXIT PARAGRAPH
           END-IF
           
           *> Check if Customer ID already exists (open INPUT first)
           MOVE "N" TO WS-FOUND
           MOVE "N" TO WS-EOF
           OPEN INPUT CUSTOMER-FILE
           PERFORM UNTIL WS-EOF = "Y" OR WS-FOUND = "Y"
                   READ CUSTOMER-FILE
                   AT END
                      MOVE "Y" TO WS-EOF
                   NOT AT END
                       IF CUSTOMER-ID = WS-INPUT-CUST-ID
                          MOVE "Y" TO WS-FOUND
                       END-IF
                   END-READ
           END-PERFORM
           CLOSE CUSTOMER-FILE
           
           IF WS-FOUND = "Y"
              DISPLAY "Customer ID already exists. Enter another ID."
              EXIT PARAGRAPH
           END-IF
           
           *> ID is unique, proceed to create customer
           MOVE WS-INPUT-CUST-ID TO CUSTOMER-ID
           DISPLAY "Enter Name: "
           ACCEPT CUSTOMER-NAME
           
           *> Now open for EXTEND to write the new customer
           OPEN EXTEND CUSTOMER-FILE
           WRITE CUSTOMER-RECORD
           CLOSE CUSTOMER-FILE
           DISPLAY "Customer created successfully."
           EXIT PARAGRAPH.

       OPEN-ACCOUNT.
           DISPLAY "Opening a new account..."
           DISPLAY "Enter Customer ID (6 digits): "
           ACCEPT WS-SEARCH-ID-TXT
             *> Verify if customer exists
           MOVE "N" TO WS-FOUND
           MOVE "N" TO WS-EOF
           OPEN INPUT CUSTOMER-FILE
           PERFORM UNTIL WS-EOF = "Y"
                   READ CUSTOMER-FILE
                   AT END
                      MOVE "Y" TO WS-EOF
                   NOT AT END
                       IF CUSTOMER-ID = WS-SEARCH-ID-TXT
                          MOVE "Y" TO WS-FOUND
                       END-IF
                   END-READ
           END-PERFORM
           CLOSE CUSTOMER-FILE
           IF WS-FOUND = "Y"
              DISPLAY "Customer found. Proceeding to open account."
              DISPLAY "Enter Account Number (10 digits): "
              ACCEPT ACCOUNT-NUMBER
              DISPLAY "Enter Account Type (e.g., Savings, Checking): "
              ACCEPT ACCOUNT-TYPE
              MOVE 0 TO ACCOUNT-BALANCE

              OPEN EXTEND ACCOUNT-FILE
              WRITE ACCOUNT-RECORD
              CLOSE ACCOUNT-FILE
              DISPLAY "Account opened successfully."
           ELSE
              DISPLAY "Customer ID not found. Cannot open account."
           END-IF
           EXIT PARAGRAPH.

       EXIT-MESSAGE.
           DISPLAY "Goodbye.".
           STOP RUN.

      
       END PROGRAM BANKSYSTEM.
         *> end program marks the end of the program.
