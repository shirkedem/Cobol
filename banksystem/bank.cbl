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
           SELECT CUSTOMER-FILE ASSIGN TO "customer.dat".
           SELECT ACCOUNT-FILE ASSIGN TO "account.dat".

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
          05 CUSTOMER-ID       PIC 9(6).   *> id is numeric, 6 digits.
          05 CUSTOMER-NAME     PIC A(30).   *> name is alphanumeric, 30 chars.
          05 CUSTOMER-BALANCE  PIC 9(9)V99. 
            *> balance is numeric (9 digits before decimal, 2 after).

         FD ACCOUNT-FILE.
       01 ACCOUNT-RECORD.
          05 ACCOUNT-NUMBER    PIC 9(10).
          05 ACCOUNT-TYPE      PIC A(10).
          05 ACCOUNT-BALANCE   PIC 9(9)V99.

         *> ws section is for temp data storage during program execution.
         WORKING-STORAGE SECTION.
       01 WS-MESSAGE           PIC X(50)   VALUE "Bank system.".
       01 WS-EXIT-CONDITION    PIC X       VALUE "N".
       01 WS-USER-CHOICE       PIC X.


       PROCEDURE DIVISION.
       *> procedure div contains the executable code.
       MAIN-LOGIC.
           PERFORM UNTIL WS-EXIT-CONDITION = "Y"
                   DISPLAY "1. Create Customer"
                   DISPLAY "2. Open Account"
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
       
       CREATE-CUSTOMER.
           DISPLAY "Creating a new customer...".
            *> logic to create customer would go here.
           CONTINUE.
       OPEN-ACCOUNT.
           DISPLAY "Opening a new account...".
            *> logic to open account would go here.
           CONTINUE.
       EXIT-MESSAGE.
           DISPLAY "Goodbye.".
           STOP RUN.

      
       END PROGRAM BANKSYSTEM.
         *> end program marks the end of the program.