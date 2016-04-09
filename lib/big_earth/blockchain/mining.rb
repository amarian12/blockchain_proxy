module BigEarth 
  module Blockchain 
    class Mining
      # == Mining ==
      # getblocktemplate ( "jsonrequestobject" )
      # getmininginfo
      # getnetworkhashps ( blocks height )
      # prioritisetransaction <txid> <priority delta> <fee delta>
      # submitblock "hexdata" ( "jsonparametersobject" )
      def start
        # Start Bitcoin server.
        `bitcoind -daemon`
      end
    end
  end
end
