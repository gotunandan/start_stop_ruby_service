@ECHO OFF

cd C:\Users\nandan\start_stop_ruby_service\

:START
start /b /wait C:\Ruby200\bin\ruby.exe C:\Users\nandan\start_stop_ruby_service\init.rb
GOTO START
GOTO END

:END