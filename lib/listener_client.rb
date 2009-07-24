#
# class RMB::ListenerClient  -- Invoked by application code to start/stop listener daemon(s)
#
module RMB

  #
  # This code is called from the client application.  It starts/stops the daemon via a control script
  #
  class ListenerClient
    attr_accessor :properties
  
    # minimal initialization done here, see RMB::ListenerClient#setup for more.
    def initialize(hash)
      @properties = hash
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
      control_params = "#{properties[:working_dir]} #{properties[:key]}"
      # the params before -- are for the control program, those after -- are for the daemon, and they are the same
      system("#{control_script} #{control_params} -- #{control_params}")
    end
    
    def app_name
      properties[:daemon_options][:app_name]
    end

    def setup
      # add derived values to the daemon_options hash
      properties[:daemon_options][:app_name] = "#{RMB::Properties.daemon_prefix}#{properties[:key]}"
      properties[:daemon_options][:dir] = File.join("#{properties[:working_dir]}", "tmp", "pids")
      # Ensure the properties folder is present
      properties_dir = File.join("#{properties[:working_dir]}", "tmp", "properties")
      if !File.directory?(properties_dir)
        Dir.mkdir(properties_dir)
      end
      # dump the properties to a tmp file so the daemon can access them
      File.open(File.join("#{properties_dir}", "#{app_name}.properties"), "w+") do |f|
        Marshal.dump(properties, f)
      end
    end
    
  end
  
end
