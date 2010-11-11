module Swagger
  module RedisImpersonator
    def self.included(base)
      base.class_eval do 
        extend ClassMethods

        swallow(:server, self.to_s.split("::")[-1])
        # XXX: Called in exactly one place, so stub for now.
        # Might be nice to have some useful stats though.
        swallow(:info, [])
      end
    end

    module ClassMethods  
      def swallow(method, value=nil)
        define_method(method) do |*args|
          LOGGER.write("RedisImpersonator: Swallowed #{method} with the following arguments #{args.inspect}") if defined?(LOGGER)
          value
        end
      end

      def lint
        diff = REDIS_METHODS - instance_methods.map {|m| m.to_s }
        unless diff.empty?
          raise LintError, "Missing method(s) #{diff.join(", ")}"
        end
      end
    end

    class LintError < StandardError ; end

    REDIS_METHODS = %w( flushall srem smembers sismember sadd set get del 
      exists incrby decrby mapped_mget mget llen lset lrange lrem lpop rpush 
      ltrim keys lindex type )
    
    attr_accessor :namespace
    def namespace ; @namespace || :resque ; end
  end
end    
