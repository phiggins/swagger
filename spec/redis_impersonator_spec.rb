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

  describe ".lint" do
    it "raises a LintError for a bad RedisImpersonator" do
      klass = Class.new do
        include Swagger::RedisImpersonator
      end

      lambda { klass.lint }.should raise_error Swagger::RedisImpersonator::LintError
    end

    it "doesn't raise LintError for a good RedisImpersonator" do
      klass = Class.new do
        include Swagger::RedisImpersonator

        Swagger::RedisImpersonator::REDIS_METHODS.each do |m|
          define_method(m) {|*args| 1+1 }
        end
      end

      lambda { klass.lint }.should_not raise_error
    end
  end
end
