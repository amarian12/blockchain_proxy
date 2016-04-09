module BigEarth 
  module Blockchain 
    class Util
      def create_multi_sig nrequired
        `bitcoin-cli createmultisig #{nrequired}`
      end
      
      def estimate_fee nblocks
        `bitcoin-cli estimatefee #{nblocks}`
      end
      
      def estimate_priority nblocks
        `bitcoin-cli estimatepriority #{nblocks}`
      end
      
      def estimate_smart_fee nblocks
        `bitcoin-cli estimatesmartfee #{nblocks}`
      end
      
      def estimate_smart_priority nblocks
        `bitcoin-cli estimatesmartpriority #{nblocks}`
      end
      
      def validate_address bitcoinaddress
        `bitcoin-cli validateaddress #{bitcoinaddress}`
      end
      
      def verify_message bitcoinaddress, signature, message
        `bitcoin-cli verifymessage #{bitcoinaddress} #{signature} #{message}`
      end
    end
  end
end
