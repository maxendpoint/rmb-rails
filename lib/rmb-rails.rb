#
# = RESTful-Message-Beans module
#
# Abstraction which wraps the daemon scripts and
# handles the setup.
#
require 'listener_client'
require 'listener_main'
require 'mechanize_submitter'
require 'stomp_subscriber'
require 'submitter'
require 'subscriber'

module RMB
# This multi-level hash contains the initial set of properties needed to launch a Listener daemon.  
#* Make a writable copy of this hash
#* Fill in the areas denoted by <<fill>> with your values
#* Add additional properties required by the Subscriber and Submitter classes used
#* Pass this has as the sole parameter in listener_client = ListenerClient.new(hash) to set up the daemon
#* Call listener_client.start to start the daemon.
  RMB_Properties = {
                      :key => "<<fill>>",                               
                      :subscriber => {
                                       :class_name => "<<fill>>"   #set this to selected subclass of Subscriber
                                                                   # <== add more properties for your Subscriber here
                                     },
                      :submitter  => {
                                       :class_name => "<<fill>>"   #set this to selected subclass of Submitter
                                                                   # <== add more properties for your Submitter here
                                     },
                      :working_dir => "<<fill>>",                  #set this to the RAILS_ROOT directory
                      
                      :daemon_options => { #these options are passed directly to the class method Daemons.run(target, options)
                                              :app_name       => "",             #custom name for this daemon, set by ListenerClient#setup
                                              :ARGV           => nil,            #use the program defaults
                                              :dir_mode       => :normal,        #requires absolute path
                                              :dir            => "<<fill>>",     #this is set to "#{working_dir}/tmp/pids" by ListenerClient#setup
                                              :multiple       => false,          #this will allow multiple daemons to run
                                              :ontop          => false,          #
                                              :mode           => :load,
                                              :backtrace      => false,
                                              :monitor        => false,
                                              :log_output     => true,
                                              :keep_pid_files => true,
                                              :hard_exit      => true
                                            }
                   }
                
  LD = "listener_daemon_"   #prefix for all listener_daemon artifacts produced: pids, log files, property files, and message files
    
end  

if __FILE__ == $0
  hash = RMB::ListenerClient.properties('inventory', RAILS_ROOT, 'StompSubscriber', 'MechanizeSubmitter')
  hash[:daemon_options][:dir] = File.join("#{hash[:working_dir]}", "tmp", "pids")
  front = hash[:subscriber]
  front[:url] = '/topic/inventory'
  front[:host] = 'localhost'
  front[:port] = 61613
  front[:user] = nil
  front[:password] = nil

  back = hash[:submitter]
  back[:login_url] = 'http://localhost:3000/login'
  back[:delivery_url] = 'http://localhost:3000/documents/new'
  lc = RMB::ListenerClient.new(hash)
  puts lc.inspect
  lc.start
end
