module RMB

  class Submitter
=begin rdoc
+properties=(hash)+ This method establishes the logger for the subclass.
=end  
    def properties=(hash)
      @logger = hash[:logger]
    end
=begin rdoc
+connect+ This is an abstract method, intended to be implemented by a subclass.
=end 
    def connect
    end
=begin rdoc
+connect+ This is an abstract method, intended to be implemented by a subclass.
=end
    def send(message)
    end
  end
  
end
