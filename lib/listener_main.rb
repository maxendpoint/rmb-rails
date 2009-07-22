module RMB
  #
  # This is the class that gets instantiated from the listener daemon
  # It contains the worker code of the daemon
  #
  class ListenerMain
    attr_accessor :submitter, :subscriber, :logger, :hash
=begin rdoc
+initialize+  Given root (the working directory or RAILS_ROOT) and key (the unique identifier that denotes a 
particular Listener instance), the initialize method sets up the entire daemon.  
* The daemon name is created from the key
* A logger object is instantiated for the use of the daemon components
* A hash of properties is read from a properties file, whose name is also derived from the root and key.
* An instance of a subclass of Subscriber is created to act as the front end of the daemon, listening on a topic or queue for the arrival of a message
* An instance of a subclass of Submitter is created to send messages on to a parent rails app, using RESTful techniques to send the message to a rails controller.
=end    
    def initialize(root, key)
      @key = key
      @logger = Logger.new("#{root}/log/#{app_name}.log")
      @logger.info "\nStarting #{File.basename(__FILE__)} --> #{app_name}..."
      @hash = nil
      # load the marshalled hash of properties
      f = File.join("#{root}", "tmp", "properties", "#{app_name}.properties")
      File.open(f) do |props|
        @hash = Marshal.load(props)
      end
      @hash[:logger] = @logger
      # instantiate the two objects that comprise the front-end and the back-end of 
      # this listener daemon
      front = @hash[:subscriber]
      @subscriber = Kernel.eval "#{front[:class_name]}.new"
      @subscriber.properties=@hash
      back = @hash[:submitter]
      @submitter = Kernel.eval "#{back[:class_name]}.new"
      @submitter.properties=@hash
    end
=begin rdoc
+run+ 
* The subscriber is connected to a message broker, 
* the submitter is connected to the rails controller,
* then an infinite loop is entered
* subscriber waits to receive a message
* when a message arrives, it is sent to the rails controller via the submitter
* ...and loop forever
=end
    def run
      begin
        subscriber.connect
        logger.info "subscriber connected."
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
      begin
        submitter.connect
        logger.info "submitter logged in."
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
      logger.info "Waiting for messages in #{subscriber.url}."
      loop do
        begin
          message = subscriber.receive
        rescue
          logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
          raise
        end
        begin
          submitter.send(message)
        rescue Exception
          logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
          raise
        end
      end
    end
    
    def app_name
      "#{LD}#{@key}"
    end
  end

end
