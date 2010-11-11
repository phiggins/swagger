module Swagger
  module ResqueStubs
    def redis=(*args)
      @redis ||= Swagger.impersonator_klass.new

      # Hacks for compatibility with Resque tests
      namespace = String === args.first && args.first[ %r|/([^/]*)|, 1]
      @redis.namespace = namespace if namespace
      @redis
    end
    
    def connect_to_database(database)
      ResqueValue.establish_connection database
    end
  end  

  module ResqueStubber
    def swagger!
      Resque.send(:extend, ResqueStubs)
    end
  end
end

Resque.send(:extend, Swagger::ResqueStubber)
