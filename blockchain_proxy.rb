#$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/workers"
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/big_earth/blockchain"
require 'sinatra/base'
require "sinatra/config_file"
require 'sinatra/json'
require 'json'
#require 'resque'
require 'blockchain'
require 'control'
require 'generate'
require 'mining'
require 'network'
require 'transaction'
require 'util'
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
      
      get '/hello.json' do
        { status: 'world' }.to_json
        #Resque.enqueue BigEarth::Blockchain::BootstrapChefClient, config
      end
      
      # Blockchain
      get '/get_best_block_hash.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        { hash: blockchain.get_best_block_hash }.to_json
      end
      
      get '/get_block.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        if params['verbose'] == 'true'
          blockchain.get_block params['hash'], params['verbose']
        elsif params['verbose'] == 'false'
          { hex: blockchain.get_best_block_hash }.to_json
        end
      end
      
      get '/get_blockchain_info.json' do
        blockchain = BigEarth::Blockchain::Blockchain.new
        blockchain.get_blockchain_info
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
      
      # Control
      post '/start.json' do
        control = BigEarth::Blockchain::Control.new
        { status: control.start }.to_json
      end
      
      post '/stop.json' do
        control = BigEarth::Blockchain::Control.new
        { status: control.stop }.to_json
      end
      
      get '/get_info.json' do
        content_type :json
        control = BigEarth::Blockchain::Control.new
        control.get_info
      end
      
      # Generate
      get '/generate.json/:numblocks' do
        generate = BigEarth::Blockchain::Generate.new
        generate.generate param[:numblocks]
      end
      
      get '/get_generate.json' do
        generate = BigEarth::Blockchain::Generate.new
        { generate: generate.get_generate }.to_json
      end
      
      get '/set_generate.json/:generate' do
        generate = BigEarth::Blockchain::Generate.new
        generate.set_generate param[:generate]
      end
      
      # Mining
      get '/get_block_template.json/:jsonrequestobject' do
        mining = BigEarth::Blockchain::Mining.new
        mining.get_block_template param[:jsonrequestobject]
      end
      
      get '/get_mining_info.json' do
        mining = BigEarth::Blockchain::Mining.new
        mining.get_mining_info
      end
      
      get '/get_network_hashps.json/:blocks' do
        mining = BigEarth::Blockchain::Mining.new
        mining.get_network_hashps param[:blocks]
      end
      
      get '/prioritise_transaction.json/:txid' do
        mining = BigEarth::Blockchain::Mining.new
        mining.prioritise_transaction param[:txid]
      end
      
      get '/submit_block.json/:hexdata' do
        mining = BigEarth::Blockchain::Mining.new
        mining.submit_block param[:hexdata]
      end
      
      # Network
      get '/add_node.json/:node/:type' do
        network = BigEarth::Blockchain::Network.new
        network.add_node param[:node], param[:type]
      end
      
      get '/disconnect_node.json/:node' do
        network = BigEarth::Blockchain::Network.new
        network.disconnect_node param[:node]
      end
      
      get '/get_added_node_info.json/:dns' do
        network = BigEarth::Blockchain::Network.new
        network.get_added_node_info param[:dns]
      end
      
      get '/get_connection_count.json' do
        network = BigEarth::Blockchain::Network.new
        { connection_count: network.get_connection_count }.to_json
      end
      
      get '/get_net_totals.json' do
        network = BigEarth::Blockchain::Network.new
        network.get_net_totals
      end
      
      get '/get_network_info.json' do
        network = BigEarth::Blockchain::Network.new
        network.get_network_info
      end
      
      get '/get_peer_info.json' do
        network = BigEarth::Blockchain::Network.new
        network.get_peer_info
      end
      
      get '/list_banned.json' do
        network = BigEarth::Blockchain::Network.new
        network.list_banned
      end
      
      get '/ping.json' do
        network = BigEarth::Blockchain::Network.new
        network.ping
      end
      
      get '/set_ban.json/:ip/:type/:bantime/:absolute' do
        network = BigEarth::Blockchain::Network.new
        network.set_ban param[:ip], param[:type], param[:bantime], param[:absolute]
      end
      
      # Transaction
      get '/create_raw_transaction.json/:txid/:address' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.create_raw_transaction param[:txid], param[:address]
      end
      
      get '/decode_raw_transaction.json/:hexstring' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.decode_raw_transaction param[:hexstring]
      end
      
      get '/decode_script.json/:hex' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.decode_script param[:hex]
      end
      
      get '/get_raw_transaction.json/:txid' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.get_raw_transaction param[:txid]
      end
      
      get '/send_raw_transaction.json/:hexstring' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.send_raw_transaction param[:hexstring]
      end
      
      get '/sign_raw_transaction.json/:hexstring' do
        transaction = BigEarth::Blockchain::Transaction.new
        transaction.sign_raw_transaction param[:hexstring]
      end
      
      # Util
      get '/create_multi_sig.json/:nrequired' do
        util = BigEarth::Blockchain::Util.new
        util.create_multi_sig param[:nrequired]
      end
      
      get '/estimate_fee.json/:nblocks' do
        util = BigEarth::Blockchain::Util.new
        util. param[:nblocks]
      end
      
      get '/estimate_priority.json/:nblocks' do
        util = BigEarth::Blockchain::Util.new
        util.estimate_priority param[:nblocks]
      end
      
      get '/estimate_smart_fee.json/:nblocks' do
        util = BigEarth::Blockchain::Util.new
        util.estimate_smart_fee param[:nblocks]
      end
      
      get '/estimate_smart_priority.json/:nblocks' do
        util = BigEarth::Blockchain::Util.new
        util.estimate_smart_priority param[:nblocks]
      end
      
      get '/validate_address.json/:bitcoinaddress' do
        util = BigEarth::Blockchain::Util.new
        util.validate_address param[:bitcoinaddress]
      end
      
      get '/verify_message.json/:bitcoinaddress/:signature/:message' do
        util = BigEarth::Blockchain::Util.new
        util.verify_message param[:bitcoinaddress], param[:signature], param[:message]
      end
    end
  end
end
