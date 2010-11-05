module Swagger
  module RedisImpersonator
    def self.included(base)
      base.class_eval do 
        extend ClassMethods

        swallow(:namespace=)
        swallow(:namespace, 'not applicable')
        swallow(:server, self.to_s.split("::")[-1])
        swallow(:info,   self.inspect)
      end
    end

    module ClassMethods  
      def swallow(method, value=nil)
        define_method(method) do |*args|
          LOGGER.write("RedisImpersonator: Swallowed #{method} with the following arguments #{args.inspect}") if defined?(LOGGER)
          value
        end
      end
    end

    def srem(set_name, value)
    end
    
    def smembers(set_name)
    end

    def sismember(set_name, value)
    end
    
    def sadd(set_name, value)
    end
    
    def set(key, value)
    end

    def get(key)
    end
    
    def del(key)
    end
    
    def exists(key)
    end
    
    def incrby(key, value)
    end
    
    def decrby(key, value)
    end
      
    def mapped_mget(*keys)
    end
    
    def mget(*keys)
    end    
        
    def llen(list_name)
    end
    
    def lset(list_name, index, value)
    end
      
    def lrange(list_name, start_range, end_range)
    end

    
    def lrem(list_name, count, value)
    end
    
    def lpop(list_name)
    end
    
    def rpush(list_name, value)
    end
    
    def ltrim(list_name, start_range, end_range)
    end
    
    def keys(pattern = '*')
    end

  end
end
