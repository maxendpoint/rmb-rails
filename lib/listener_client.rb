module RMB

  #
  # This code is called from the client application.  It starts/stops the daemon via a control script
  #
  class ListenerClient
  
    def initialize(hash)
      @hash = hash
    end
    
    def start
      control('start')
    end
  
    def stop
      control('stop')
    end
    
    def control(action)
      setup
      control_script = "ruby #{File.dirname(__FILE__)}/#{RMB::Properties.daemon_prefix}control.rb #{action}"
      control_params = "#{@hash[:working_dir]} #{@hash[:key]}"
      system("#{control_script} #{control_params} -- #{control_params}")
    end
    
    def app_name
      @hash[:daemon_options][:app_name]
    end

    def properties=(hash)
      @hash=hash
    end

    def properties
      @hash
    end

private

    def setup
      # add derived values to the daemon_options hash
      @hash[:daemon_options][:app_name] = "#{RMB::Properties.daemon_prefix}#{@hash[:key]}"
      @hash[:daemon_options][:dir] = File.join("#{@hash[:working_dir]}", "tmp", "pids")
      # Ensure the properties folder is present
      properties_dir = File.join("#{@hash[:working_dir]}", "tmp", "properties")
      if !File.directory?(properties_dir)
        Dir.mkdir(properties_dir)
      end
      # dump the properties to a tmp file
      File.open(File.join("#{properties_dir}", "#{app_name}.properties"), "w+") do |f|
        Marshal.dump(@hash, f)
      end
    end
    
  end
  
end
