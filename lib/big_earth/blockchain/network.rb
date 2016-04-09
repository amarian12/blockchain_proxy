module BigEarth 
  module Blockchain 
    class Network
      def add_node node, type
        `bitcoin-cli addnode #{node} #{type}`
      end
      
      def clear_banned
        `bitcoin-cli clearbanned`
      end
      
      def disconnect_node node
        `bitcoin-cli disconnectnode #{node}`
      end
      
      def get_added_node_info dns
        `bitcoin-cli getaddednodeinfo #{dns}`
      end
      
      def get_connection_count
        `bitcoin-cli getconnectioncount`
      end
      
      def get_net_totals
        `bitcoin-cli getnettotals`
      end
      
      def get_network_info
        `bitcoin-cli getnetworkinfo`
      end
      
      def get_peer_info
        `bitcoin-cli getpeerinfo`
      end
      
      def list_banned
        `bitcoin-cli listbanned`
      end
      
      def ping
        `bitcoin-cli ping`
      end
      
      def set_ban ip, type, bantime, absolute
        `bitcoin-cli setban #{ip} #{type} #{bantime} #{absolute}`
      end
    end
  end
end
