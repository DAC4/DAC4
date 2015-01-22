**********ARDUINO UTILISATION*********

ArduinoInterface allows to interact with Arduino, wich can control the
boxes' lockers.

The application hasn't been tested with Arduino so all the Arduino commands
in the code are comments, they begin by "/* ARDUINO : ".

In order to make the Arduino Interface work, it's needed first to import
the "ArduinoManager" folder into the project.

To connect the application with the Arduino using USB, you have to use
the initialisation() function in ArduinoInterface.

Their are some calls to ArduinoInterface in comments in the code :
    + In ItemServlet :
            -   In onItemReturnRequest
            -   In onItemBorrowRequest
            -   In onItemRegistrationRequest

    + In UserServlet :
            -   In onItemRemoveRequest

    + In AdminItemServlet :
            -   In onRemoveItemRequest