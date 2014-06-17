require 'rubygems'
require 'daemons'

pwd  = File.dirname(File.expand_path(__FILE__))
file = pwd + '/init.rb'

Daemons.run_proc(
  'start_stop_service',
  log_output: true
  ) do 
    exec "C:\\Ruby200\\bin\\ruby.exe #{file}"
  end