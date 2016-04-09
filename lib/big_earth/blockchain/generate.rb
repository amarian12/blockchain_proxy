module BigEarth 
  module Blockchain 
    class Generate
      def generate numblocks
        # Mine blocks immediately (before the RPC call returns)
        # 
        # Note: this function can only be used on the regtest network
        # 
        # Arguments:
        # 1. numblocks    (numeric, required) How many blocks are generated immediately.
        # 
        # Result
        # [ blockhashes ]     (array) hashes of blocks generated
        # 
        # Examples:
        # 
        # Generate 11 blocks
        # > bitcoin-cli generate 11
        `bitcoin-cli generate #{numblocks}`
      end
      
      def get_generate
        # Return if the server is set to generate coins or not. The default is false.
        # It is set with the command line argument -gen (or bitcoin.conf setting gen)
        # It can also be set with the setgenerate call.
        # 
        # Result
        # true|false      (boolean) If the server is set to generate coins or not
        # 
        # Examples:
        # > bitcoin-cli getgenerate
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getgenerate", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getgenerate`
      end
      
      def set_generate generate, genproclimit
        # Set 'generate' true or false to turn generation on or off.
        # Generation is limited to 'genproclimit' processors, -1 is unlimited.
        # See the getgenerate call for the current setting.
        # 
        # Arguments:
        # 1. generate         (boolean, required) Set to true to turn on generation, off to turn off.
        # 2. genproclimit     (numeric, optional) Set the processor limit for when generation is on. Can be -1 for unlimited.
        # 
        # Examples:
        # 
        # Set the generation on with a limit of one processor
        # > bitcoin-cli setgenerate true 1
        # 
        # Check the setting
        # > bitcoin-cli getgenerate
        # 
        # Turn off generation
        # > bitcoin-cli setgenerate false
        # 
        # Using json rpc
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgenerate", "params": [true, 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli setgenerate #{generate} #{genproclimit}`
      end
    end
  end
end
