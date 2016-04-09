module BigEarth 
  module Blockchain 
    class Transaction
      # == Rawtransactions ==
      # createrawtransaction [{"txid":"id","vout":n},...] {"address":amount,"data":"hex",...} ( locktime )
      # decoderawtransaction "hexstring"
      # decodescript "hex"
      # getrawtransaction "txid" ( verbose )
      # sendrawtransaction "hexstring" ( allowhighfees )
      # signrawtransaction "hexstring" ( [{"txid":"id","vout":n,"scriptPubKey":"hex","redeemScript":"hex"},...] ["privatekey1",...] sighashtype )
      def start
        # Start Bitcoin server.
        `bitcoind -daemon`
      end
    end
  end
end
