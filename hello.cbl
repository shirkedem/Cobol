       identification division.

       program-id. hello.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 WS-DATETIME pic X(20).
       01 WS-NAME      pic x(4) value "Shir".
       01 WS-MESSAGE  pic X(50) value "This is a sample COBOL program.".
       01 WS-YEAR    pic X(4).
       01 WS-MONTH   pic X(2).
       01 WS-DAY     pic X(2).
       01 WS-HOUR    pic X(2).
       01 WS-MINUTE  pic X(2).
       01 WS-SECOND  pic X(2).
       linkage section.

       procedure division.
           display WS-MESSAGE.
              move function current-date to WS-DATETIME
              move WS-DATETIME(1:4)  to WS-YEAR
              move WS-DATETIME(5:2)  to WS-MONTH
              move WS-DATETIME(7:2)  to WS-DAY
              move WS-DATETIME(9:2)  to WS-HOUR
              move WS-DATETIME(11:2) to WS-MINUTE
              move WS-DATETIME(13:2) to WS-SECOND
           display WS-NAME ", the current date and time is: "
                   WS-YEAR "-" WS-MONTH "-" WS-DAY " "
                   WS-HOUR ":" WS-MINUTE ":" WS-SECOND.
           stop run.

       end program hello.
