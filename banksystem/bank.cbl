       *> Practice exercise: Create a simple COBOL program for a banking system.
       *> Most comments are notes to self as I learn structure and syntax.
       identification division.

       program-id. banksystem.

       environment division. 
       *> env div links external files and devices to the program.
         input-output section.
         file-control.
         *> file control is a paragraph within io section. 
         *> uses to define external files linked to the program.
           select customer-file assign to "customer.dat".
           select account-file assign to "account.dat".

       data division.
       *> data div is where all data items are defined. 
       *> file section is a paragraph within data division. 
       *> used to define the structure of external files.
         file section.
         fd customer-file.
         01 customer-record.
         *> record layout for customer file (id, name, balance).
         *> 01 is level number for top-level record.
         *> 05 is for fields within the record (hierarchy).
            05 customer-id       pic 9(6). *> id is numeric, 6 digits.
            05 customer-name     pic a(30). *> name is alphanumeric, 30 chars.
            05 customer-balance  pic 9(9)V99. 
            *> balance is numeric (9 digits before decimal, 2 after).

         fd account-file.
         01 account-record.
            05 account-number    pic 9(10).
            05 account-type      pic a(10).
            05 account-balance   pic 9(9)V99.

         *> ws section is for temp data storage during program execution.
         working-storage section.
         01 WS-MESSAGE pic X(50) value "Bank system.".


       procedure division.
             display WS-MESSAGE.
             stop run.

       end program banksystem.
       