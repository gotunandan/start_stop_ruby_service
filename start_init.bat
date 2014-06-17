@ECHO OFF


TIMEOUT /T 10

E:
cd start_stop_ruby_service\

:START
start /b /wait C:\Ruby200\bin\ruby.exe E:\start_stop_ruby_service\init.rb
GOTO START
