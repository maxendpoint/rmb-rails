#
# class RMB::StompSubscriber -- A concrete instance of a Submitter subclass, which uses the stomp protocol to subscribe to an ActiveMQ broker.
#
require 'stomp'
require 'subscriber'

module RMB

class StompSubscriber < Subscriber
    attr_accessor :url, :host, :port, :user, :password, :connection, :logger
=begin rdoc
+connect+ Opens a connection with the message broker, and then subscribes on the url 
=end   
    def connect
      super
      begin
        @connection = Stomp::Connection.open(user, password, host, port)
        @connection.subscribe url, { :ack => 'auto' } 
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
      logger.info "Waiting for messages in #{url}."
    end
=begin rdoc
+properties=(hash)+ Accepts a hash object containing all of the configuration properties required. These properties are copied into instance variables.
=end  
    def properties=(hash)
      subscriber = hash[:subscriber]
      @url = subscriber[:url] || "/queue/something"
      @host = subscriber[:host] || ""
      @port = subscriber[:port] || 61613
      @user = subscriber[:user] || ""
      @password = subscriber[:password] || ""
      @connection = nil
      super
    end
=begin rdoc
+receive+ Executes a receive on the connection, thus blocking the daemon until a message arrives.  Then answers the message.
=end    
    def receive
      super
      begin
        message = @connection.receive
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
      logger.info "Received message: #{message.inspect}"
      message
    end
  end

end
