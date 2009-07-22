require 'mechanize'
require 'submitter'

module RMB
  
  class MechanizeSubmitter < Submitter
    attr_accessor :user, :password, :login_url, :delivery_url, :agent, :logger, :agent, :daemon_name
=begin rdoc
+properties=(hash)+ Accepts a hash object containing all of the configuration properties required. These properties are copied into instance variables.
=end  
    def properties=(hash)
      super
      @hash = hash
      @daemon_name = "#{RMB::Properties.daemon_prefix}#{hash[:key]}"
      submitter = hash[:submitter]
      @user = submitter[:user] || ""
      @password = submitter[:password] || ""
      @login_url = submitter[:login_url] || ""
      @delivery_url = submitter[:delivery_url] || ""
      begin
        @agent = WWW::Mechanize.new 
        @agent.user_agent_alias = 'Linux Mozilla'
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
    end
=begin rdoc
+connect+ Uses the login_url property, along with the user and password properties, to log in to the rails app.
=end  
    def connect
      super
      #this code requires completion of the User controller in the main app
    end
=begin rdoc
+marshal_message_body+ Extracts the message body from the rest of the message, and marshals it into a file.  The name of this file will be submitted to the rails app, along with other message attributes.
=end  
    def marshal_message_body(message)
      file = File.join("#{@hash[:working_dir]}", "tmp", "messages", "#{daemon_name}_#{message.headers["timestamp"]}.message")
      File.open(file, "w+") do |f|
        Marshal.dump(message.body, f)
      end
      file
    end
=begin rdoc
+send+ This method uses the +delivery_url+ property to issue a get request to retrieve the <tt>new document</tt> form from the rails app.  The form is filled in with message attributes and submitted to the rails app for processing.
=end    
    def send(message)
      super
      file = marshal_message_body(message)
      begin
        page = agent.get(delivery_url)
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
      form = page.forms.first
      
      # I can't seem to make the Mechanize code recognize fields as attributes, so
      # I am forced to treat them as an array
      form.fields[1].value = @hash[:key]
      form.fields[2].value = message.headers["destination"]
      form.fields[3].value = message.headers["message-id"]
      form.fields[4].value = message.headers["content-type"]
      form.fields[5].value = message.headers["priority"]
      form.fields[6].value = message.headers["content-length"]
      form.fields[7].value = message.headers["timestamp"]
      form.fields[8].value = message.headers["expires"]
      form.fields[9].value = file
      
      #logger.info "final form: #{form.inspect}"
      
      #submit the form
      begin
        page = agent.submit(form)
      rescue Exception
        logger.fatal "#{__FILE__}:#{__LINE__} Exception #{$!}"
        raise
      end
    end
  end
  
end
