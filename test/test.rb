# test.rb
require File.expand_path '../test_helper.rb', __FILE__

class MyTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    BigEarth::Blockchain::BlockchainProxy  
  end

  def test_hello_world
    puts 'yo'
    get '/'
    assert last_response.ok?
    assert_equal "Hello, World!", last_response.body
  end
end
