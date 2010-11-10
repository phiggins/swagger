# HAX!
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/swagger/stubs'))

require 'resque'

require 'swagger/redis_impersonator'
require 'swagger/resque_extension'
require 'swagger/version'

module Swagger
  class << self
    attr_accessor :impersonator_klass, :logger
  end
end
