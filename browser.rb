
require 'win32/process'
require 'yaml'

class Browser

  def initialize

    @paths = YAML.load_file("paths.yml")

    @is64 = File.directory?(@paths["wow64"])

    @stop_hash = {
      "opera" => "opera.exe",
      "ie" => "iexplore.exe",
      "firefox" => "firefox.exe",
      "chrome" => "chrome.exe"
    }

    @clean_hash = {
      "ie" => "IE",
      "firefox" => "FIREFOX",
      "chrome" => "CHROME",
      "opera" => "OPERA",
      "opera_new" => "OPERA_NEW"
    }

  end
 

  def start(name, version, url, proxy, port)

    puts("\n")
    puts("name #{name} version #{version} url #{url} proxy #{proxy} port #{port}")

    proxy_command = @paths["proxy"]

    if proxy != nil
      `\"#{proxy_command}\" SET #{proxy} #{port}`
      puts("Proxy set to #{proxy}:#{port}")
    else
      `\"#{proxy_command}\" UNSET`
      puts("Proxy has been unset")
    end

    if name == 'opera' && version >= '15'
      name = 'opera_new'
    end

    if @is64 == true
      name += '64'
    end

    command = "#{@paths[name]}"
    puts("command is #{command}")

    pid_info = Process.create(
      :command_line     => "#{command} #{url}",
      :creation_flags   => Process::DETACHED_PROCESS,
      :process_inherit  => false,
      :thread_inherit   => true, 
    )
    puts("PID is #{pid_info}")

  end


  def stop(name, version)

    process_name = @stop_hash[name]

    tasklist = @paths["tasklist"]
    killer = @paths["taskkill"]

    puts("Trying to terminate without force")
    args = "/IM"
    `\"#{killer}\" #{args} #{process_name}`

    sleep 2
    running = `\"#{tasklist}\" | findstr #{process_name}`
    puts("Processes still running --- \n#{running}")

    if running.split()[0] == process_name
      args = "/F /IM"
      puts("Killing with force")
      `\"#{killer}\" #{args} #{process_name}`
    end

    puts("Process #{process_name} killed")

    sleep 5
    puts("\nCalling clean for #{process_name}")
    clean(name, version)
  end


  def clean(name, version)

    clean_command = @paths["clean"]

    if name == 'opera' && version >= '15'
      name = 'opera_new'
    end

    clean_name = @clean_hash[name]

    puts("Clean name #{clean_name}")
    puts("Clean command #{clean_command}")

    puts("Running clean command for #{name}")
    `\"#{clean_command}\" #{clean_name}`

  end


end