module BigEarth 
  module Blockchain 
    class Util
      # == Util ==
      # createmultisig nrequired ["key",...]
      # estimatefee nblocks
      # estimatepriority nblocks
      # estimatesmartfee nblocks
      # estimatesmartpriority nblocks
      # validateaddress "bitcoinaddress"
      # verifymessage "bitcoinaddress" "signature" "message"
      def start
        # Start Bitcoin server.
        `bitcoind -daemon`
      end
    end
  end
end
