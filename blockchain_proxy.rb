#$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/workers"
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/big_earth/blockchain"
require 'sinatra/base'
require "sinatra/config_file"
require 'sinatra/json'
require 'json'
#require 'resque'
require 'blockchain'
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
      
      # control
      
      get '/start.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { status: blockchain.start }.to_json
      end
      
      get '/stop.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { status: blockchain.stop }.to_json
      end
      
      get '/get_best_block_hash.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { hash: blockchain.get_best_block_hash }.to_json
      end
      
      get '/get_block.json/:hash' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_block params['hash']
      end
      
      get '/get_block_chain_info.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_block_chain_info
      end
      
      get '/get_block_count.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { block_count: blockchain.get_block_count }.to_json
      end
      
      get '/get_block_hash.json/:index' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { block_hash: blockchain.get_block_hash(params[:index]) }.to_json
      end
      
      get '/get_block_header.json/:hash' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_block_header params[:hash]
      end
      
      get '/get_chain_tips.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_chain_tips
      end
      
      get '/get_difficulty.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { difficulty: blockchain.get_difficulty }.to_json
      end
      
      get '/get_info.json' do
        content_type :json
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_info
      end
      
      get '/get_mem_pool_info.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_mem_pool_info
      end
      
      get '/get_raw_mem_pool.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_raw_mem_pool
      end
      
      get '/get_tx_out.json/:n' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_tx_out params[:n]
      end
      
      get '/get_tx_out_proof.json/:txid/:blockhash' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_tx_out_proof params[:txid], params[:blockhash]
      end
      
      get '/get_tx_outset_info.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_tx_outset_info
      end
      
      get '/verify_chain.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { verified: blockchain.verify_chain }.to_json
      end
      
      get '/verify_tx_out_proof.json/:proof' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.verify_chain param[:proof]
      end
    end
  end
end
