require 'spec_helper'

describe 'Resque' do
  describe 'redis=' do
    it "doesn't allow resetting the impersonator instance" do
      redis = Resque.redis
      Resque.redis = "foo"
      Resque.redis.should == redis
    end

    it "allows setting the impersonator's namespace with a redis url" do
      Resque.redis =  'localhost:9736/namespace'
      Resque.redis.namespace.should == "namespace"
    end
  end
end
