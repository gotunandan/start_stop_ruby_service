
require 'win32/process'

class Browser

  def initialize

    @start_hash = {
      opera: "C:\\Program Files\\Opera\\opera.exe",
      opera_new: "C:\\Program Files\\Opera\\22.0.1471.50\\opera.exe",
      ie: "C:\\Program Files\\Internet Explorer\\iexplore.exe",
      firefox: "C:\\Program Files\\Mozilla Firefox\\firefox.exe",
      chrome: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
    }

    @stop_hash = {
      opera: "opera.exe",
      ie: "iexplore.exe",
      firefox: "firefox.exe",
      chrome: "chrome.exe"
    }

    @clean_hash = {
      ie: [],
      firefox: [],
      chrome: [],
      opera: [],
      opera_new: []
    }

  end


  def start_browser(command, url)


      pid_info = Process.create(
        :command_line     => "#{command} #{url}",
        :creation_flags   => Process::DETACHED_PROCESS,
        :process_inherit  => false,
        :thread_inherit   => true,
        #:cwd              => "C:\\"
      )
      "PID is #{pid_info}"

  end

  def start(name, version, url, proxy, port)

    puts("name #{name}** version #{version}** url #{url}** proxy #{proxy}** port #{port}**")

    command = "#{@start_hash[name.to_sym]}"
    puts("command is #{command}")


    proxy_command = "C:\\Users\\nandan\\browser_actions\\proxy.bat"
    if proxy != nil
      `\"#{proxy_command}\" SET #{proxy} #{port}`
      puts("Proxy set to #{proxy}:#{port}")
    else
      `\"#{proxy_command}\" UNSET`
      puts("Proxy has been unset")
    end



    if name == 'opera' && version >= '15'
      name = 'opera_new'

      command = "#{@start_hash[name.to_sym]}"
      puts("inside opera command #{command}")


      start_browser(command, url)

      #pid = Process.spawn("#{command}") #{url}")

      #Thread.new do 
      #  retval = `\"#{command}\" #{url}`
      #end


    elsif name == 'opera'
      if proxy != nil
      end

      info = start_browser(command, url)
      puts("#{info}")

    end


    if name == 'ie'
      #proxy_command = "C:\\Users\\nandan\\browser_actions\\ieproxy.bat"
      #if proxy != nil
      #  `\"#{proxy_command}\" SET #{proxy} #{port}`
      #else
      #  `\"#{proxy_command}\" UNSET`
      #end

      info = start_browser(command, url)
      puts("#{info}")


    elsif name == 'chrome'
      #if proxy != nil
      #if proxy != '' || proxy != ' '
        #proxy_command = " --proxy-server=\"http=#{proxy}:#{port};ftp=#{proxy}:#{port};https=#{proxy}:#{port}\" "
       # proxy_command = " --proxy-server=#{proxy}:#{port}"
      #else
       # proxy_command = " --no-proxy-server"
      #end

      puts("chrome proxy command #{proxy_command}")


      info = start_browser(command, url)
      puts("#{info}")


    elsif name == 'firefox'
      #if proxy != nil
      #  proxy_command = "C:\\Users\\nandan\\browser_actions\\firefoxproxy.bat"
      #  `\"#{proxy_command}\" SET #{proxy} #{port}`
      #end


      info = start_browser(command, url)
      puts("#{info}")


    end

    #Thread.new do 
    #  retval = `\"#{command}\" #{url}`
    #end

  end

  def stop(name, version)

    process_name = @stop_hash[name.to_sym]
    killer = "C:\\Windows\\System32\\taskkill.exe"
    tasklist = "C:\\Windows\\System32\\tasklist.exe"
    args = "/IM"
    `\"#{killer}\" #{args} #{process_name}`

    sleep 1
    running = `\"#{tasklist}\" | findstr #{process_name}`
    puts("running is \n#{running}")

    if running.split()[0] == process_name
      args = "/F /IM"
      `\"#{killer}\" #{args} #{process_name}`
    end

    puts("Process #{process_name} killed")

    puts("Calling clean for #{process_name}")
    clean(name, version)
  end

  def clean(name, version)

    clean_command = "C:\\Users\\nandan\\browser_actions\\clean.bat"

    if name == "ie"
      `\"#{clean_command}\" IE`

    elsif name == "firefox"
      `\"#{clean_command}\" FIREFOX`

    elsif name == "chrome"
      `\"#{clean_command}\" CHROME`

    elsif name == "opera"

      if version >= '15'
        `\"#{clean_command}\" OPERA_NEW`
      else
        `\"#{clean_command}\" OPERA`
      end
    end

  end


end