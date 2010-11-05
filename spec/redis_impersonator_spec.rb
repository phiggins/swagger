require 'spec_helper'

describe Swagger::RedisImpersonator do
  describe ".swallow" do
    it "returns nil for method with no return value" do
      subklass = Class.new do
        include Swagger::RedisImpersonator
        swallow(:no_return)
      end

      subklass.new.no_return.should == nil      
    end

    it "returns default return value" do
      klass = Class.new do
        include Swagger::RedisImpersonator
        swallow(:power_level, 9001)
      end
      
      klass.new.power_level.should == 9001
    end
  end
end
