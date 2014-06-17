start_stop_ruby_service
=======================

The start_init.bat file should be copied to the "Startup" directory in Windows. 
On Windows the path is "C:\Users\nandan\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

The Server starts when the user logs in.

To send commands to the Server -

Use curl to connect to connect to the server.

Example - curl.exe "localhost:9292/start&name=ie&version=11&url=yahoo.com"
