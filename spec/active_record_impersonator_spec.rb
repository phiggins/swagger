require 'spec_helper'
require 'active_record_spec_helper'

describe "Swagger::Impersonators::ActiveRecord" do
  describe "Swagger" do
    it 'sets impersonator_klass' do
      Swagger.impersonator_klass.should == Swagger::Impersonators::ActiveRecord
    end
  end

  describe "Resque" do
    it 'swaps redis implementation with impersonator' do
      Resque.redis.should be_a(Swagger::Impersonators::ActiveRecord)
    end  
    
    it 'can connect to the database' do
      Resque.should.respond_to?(:connect_to_database)
    end
  end

  it_should_behave_like "RedisImpersonator"
end
