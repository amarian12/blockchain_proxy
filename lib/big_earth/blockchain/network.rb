module BigEarth 
  module Blockchain 
    class Network
      # == Network ==
      # addnode "node" "add|remove|onetry"
      # clearbanned
      # disconnectnode "node"
      # getaddednodeinfo dns ( "node" )
      # getconnectioncount
      # getnettotals
      # getnetworkinfo
      # getpeerinfo
      # listbanned
      # ping
      # setban "ip(/netmask)" "add|remove" (bantime) (absolute)
      def start
        # Start Bitcoin server.
        `bitcoind -daemon`
      end
    end
  end
end
