#$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/workers"
#$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/big_earth/blockchain"
require 'sinatra/base'
require "sinatra/config_file"
require 'sinatra/json'
require 'json'
require 'resque'
module BigEarth
  module Blockchain
    class BlockchainProxy < Sinatra::Base

      register Sinatra::ConfigFile
      config_file './config.yml'
      
      use Rack::Auth::Basic, "Restricted Area" do |username, password|
        # Use a *very* strong user/pass
        # TODO: Consider more robust solution than Basic HTTP Auth
        username == ENV['BLOCKCHAIN_PROXY_USERNAME'] and password == ENV['BLOCKCHAIN_PROXY_PASSWORD']
      end
      
      get '/ping.json' do
        content_type :json
        { status: 'pong' }.to_json
        #Resque.enqueue BigEarth::Blockchain::BootstrapChefClient, config
      end
      
      get '/get_info.json' do
        content_type :json
        blockchain = Blockchain.new
        info = blockchain.get_info
        { 
          status: 200,
          info: info
         }.to_json
        #Resque.enqueue BigEarth::Blockchain::BootstrapChefClient, config
      end
    end
  end
end
