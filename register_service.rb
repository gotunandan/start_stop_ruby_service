# register_service.rb
require 'win32/service'
include Win32

SERVICE_NAME = 'Start_Stop_Service'

# Create a new service
Service.create({
  :service_name       => SERVICE_NAME,
  :service_type       => (Service::WIN32_OWN_PROCESS)|(Service::INTERACTIVE_PROCESS),
  :description        => 'start stop browser service',
  :start_type         => Service::AUTO_START,
  :error_control      => Service::ERROR_NORMAL,
  :binary_path_name   => 'c:\Ruby200\bin\ruby.exe -C c:\Users\nandan\start_stop_service service.rb',
  :display_name       => SERVICE_NAME
})

