module BigEarth 
  module Blockchain 
    class Transaction
      def create_raw_transaction txid, address
        `bitcoin-cli createrawtransaction #{txid} #{address}`
      end
      
      def decode_raw_transaction hexstring
        `bitcoin-cli decoderawtransaction #{hexstring}`
      end
      
      def decode_script hex
        `bitcoin-cli decodescript`
      end
      
      def get_raw_transaction txid
        `bitcoin-cli getrawtransaction #{txid}`
      end
      
      def send_raw_transaction hexstring
        `bitcoin-cli sendrawtransaction #{hexstring}`
      end
      
      def sign_raw_transaction hexstring
        `bitcoin-cli signrawtransaction #{hexstring}`
      end
    end
  end
end
