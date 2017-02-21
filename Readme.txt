==========================
Readme
==========================


1. Installation:
==========================

Server Application:

a. Unless bundler is already installed, install it using the command "gem install bundler".
b. Run the command "bundle install" from Code/server_application/ directory. This will install all the dependency gems.
c. Run the test suites using the command "rake spec" from Code/server_application/ directory.
d. Check code coverage by opening respective files "Code/server_application/coverage/index.html".


Client Application:

a. Unless bundler is already installed, install it using the command "gem install bundler".
b. Run the command "bundle install" from Code/client_application/ directory. This will install all the dependency gems.
c. Run the test suites using the command "rake spec" from Code/client_application/ directory.
d. Check code coverage by opening respective files "Code/client_application/coverage/index.html".


2. Initialization:
==========================

Not needed. Nothing to initialize.


3. Assumptions:
==========================

a. Test and production environment is Linux/Unix based. /dev/urandom is used as the source of the payload. So we cannot use Windows. Should work fine on Mac.
b. Payload size is defined so, no size check is used. We know the client will send no more than 1024 bytes of data. No clever chunking or buffering was implemented because of this.


4. Requirements skipped:
==========================

None.


5. How to run:
==========================
a. From server application's root directory, run server with "bin/server [hostname] [port]". CTRL+C to close server process.
f. From client application's root directory, run client with "bin/client [hostname] [port] [logfile]".
g. Check sever log in server_log/ directory under server application's root directory.


6. Issues faced:
==========================

None.


7. Constructive Feedback:
==========================

Instruction says, this is a 7 day project. Then I got an email telling me I had 3 total days to finish it. But I could extent the time. So, I think it was just a miscommunication and the instuction probably needs to be updated.
