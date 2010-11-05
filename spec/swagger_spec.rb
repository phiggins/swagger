require 'spec_helper'

describe Swagger do
  it 'returns a string for version' do
    Swagger.version.split(".").size == 3
  end
end
