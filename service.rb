# service.rb
#LOG_FOLDER = 'C:\\path\\to\\app\\logs'
LOG_FOLDER = 'C:\\Users\nandan\\start_stop_service\\logs'
DAEMON_LOG = "#{LOG_FOLDER}\\daemon.log"
SERVER_LOG = "#{LOG_FOLDER}\\thin.log"

begin
  require 'C:\Users\nandan\start_stop_service\init'
  require 'C:\Users\nandan\start_stop_service\browseractions'
  require 'win32/daemon'
  require 'fileutils'

  include Win32

  # Check if log folder exists or else create it
  unless File.directory?(LOG_FOLDER)
    FileUtils.mkdir_p(LOG_FOLDER)
  end

  # Redirect stdout and stderr to to server logs
  $stdout.reopen(SERVER_LOG, "w")
  $stdout.sync = true
  $stderr.reopen($stdout)

  # Log helper
  def log(msg)
    File.open(DAEMON_LOG, "a") { |f|
      f.puts "#{Time.now} #{msg}"
    }
  end

  class Daemon
    # Code that is run when you call Daemon.mainloop
    def service_main
      log "Service is starting"
      BrowserActions.run!({
        :bind => '0.0.0.0',
        :port => 9292
        #:server => 'thin'
      })
    end

    def service_stop
      log "*** Service stopped ***"
      exit!
    end

    # Puts your service_main code in a loop
    Daemon.mainloop
  end
rescue Exception => err
  log "*** Daemon failure *** err=#{err}"
  raise
end
