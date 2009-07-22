
module RMB

class Subscriber
=begin rdoc
+connect+ This is an abstract method, intended to be implemented by a subclass.
=end 
    def connect
    end
=begin rdoc
+receive+ This is an abstract method, intended to be implemented by a subclass.
=end  
    def receive
    end
=begin rdoc
+properties=(hash)+ This method establishes the logger for the subclass.
=end  
    def properties=(hash)
      @logger = hash[:logger]
    end
  end
  
end
