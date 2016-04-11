module BigEarth 
  module Blockchain 
    class Network
      def add_node node, type
        # Attempts add or remove a node from the addnode list.
        # Or try a connection to a node once.
        # 
        # Arguments:
        # 1. "node"     (string, required) The node (see getpeerinfo for nodes)
        # 2. "command"  (string, required) 'add' to add a node to the list, 'remove' to remove a node from the list, 'onetry' to try a connection to the node once
        # 
        # Examples:
        # > bitcoin-cli addnode "192.168.0.6:8333" "onetry"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addnode", "params": ["192.168.0.6:8333", "onetry"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli addnode #{node} #{type}`
      end
      
      def clear_banned
        # Clear all banned IPs.
        # 
        # Examples:
        # > bitcoin-cli clearbanned
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "clearbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli clearbanned`
      end
      
      def disconnect_node node
        # Immediately disconnects from the specified node.
        # 
        # Arguments:
        # 1. "node"     (string, required) The node (see getpeerinfo for nodes)
        # 
        # Examples:
        # > bitcoin-cli disconnectnode "192.168.0.6:8333"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "disconnectnode", "params": ["192.168.0.6:8333"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli disconnectnode #{node}`
      end
      
      def get_added_node_info dns
        # Returns information about the given added node, or all added nodes
        # (note that onetry addnodes are not listed here)
        # If dns is false, only a list of added nodes will be provided,
        # otherwise connected information will also be available.
        # 
        # Arguments:
        # 1. dns        (boolean, required) If false, only a list of added nodes will be provided, otherwise connected information will also be available.
        # 2. "node"   (string, optional) If provided, return information about this specific node, otherwise all nodes are returned.
        # 
        # Result:
        # [
        #   {
        #     "addednode" : "192.168.0.201",   (string) The node ip address
        #     "connected" : true|false,          (boolean) If connected
        #     "addresses" : [
        #        {
        #          "address" : "192.168.0.201:8333",  (string) The bitcoin server host and port
        #          "connected" : "outbound"           (string) connection, inbound or outbound
        #        }
        #        ,...
        #      ]
        #   }
        #   ,...
        # ]
        # 
        # Examples:
        # > bitcoin-cli getaddednodeinfo true
        # > bitcoin-cli getaddednodeinfo true "192.168.0.201"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddednodeinfo", "params": [true, "192.168.0.201"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getaddednodeinfo #{dns}`
      end
      
      def get_connection_count
        # Returns the number of connections to other nodes.
        # 
        # Result:
        # n          (numeric) The connection count
        # 
        # Examples:
        # > bitcoin-cli getconnectioncount
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getconnectioncount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getconnectioncount`
      end
      
      def get_net_totals
        # Returns information about network traffic, including bytes in, bytes out, and current time.
        # 
        # Result:
        # {
        #   "totalbytesrecv": n,   (numeric) Total bytes received
        #   "totalbytessent": n,   (numeric) Total bytes sent
        #   "timemillis": t,       (numeric) Total cpu time
        #   "uploadtarget":
        #   {
        #     "timeframe": n,                         (numeric) Length of the measuring timeframe in seconds
        #     "target": n,                            (numeric) Target in bytes
        #     "target_reached": true|false,           (boolean) True if target is reached
        #     "serve_historical_blocks": true|false,  (boolean) True if serving historical blocks
        #     "bytes_left_in_cycle": t,               (numeric) Bytes left in current time cycle
        #     "time_left_in_cycle": t                 (numeric) Seconds left in current time cycle
        #   }
        # }
        # 
        # Examples:
        # > bitcoin-cli getnettotals
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnettotals", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getnettotals`
      end
      
      def get_network_info
        # Returns an object containing various state info regarding P2P networking.
        # 
        # Result:
        # {
        #   "version": xxxxx,                      (numeric) the server version
        #   "subversion": "/Satoshi:x.x.x/",     (string) the server subversion string
        #   "protocolversion": xxxxx,              (numeric) the protocol version
        #   "localservices": "xxxxxxxxxxxxxxxx", (string) the services we offer to the network
        #   "timeoffset": xxxxx,                   (numeric) the time offset
        #   "connections": xxxxx,                  (numeric) the number of connections
        #   "networks": [                          (array) information per network
        #   {
        #     "name": "xxx",                     (string) network (ipv4, ipv6 or onion)
        #     "limited": true|false,               (boolean) is the network limited using -onlynet?
        #     "reachable": true|false,             (boolean) is the network reachable?
        #     "proxy": "host:port"               (string) the proxy that is used for this network, or empty if none
        #   }
        #   ,...
        #   ],
        #   "relayfee": x.xxxxxxxx,                (numeric) minimum relay fee for non-free transactions in BTC/kB
        #   "localaddresses": [                    (array) list of local addresses
        #   {
        #     "address": "xxxx",                 (string) network address
        #     "port": xxx,                         (numeric) network port
        #     "score": xxx                         (numeric) relative score
        #   }
        #   ,...
        #   ]
        #   "warnings": "..."                    (string) any network warnings (such as alert messages)
        # }
        # 
        # Examples:
        # > bitcoin-cli getnetworkinfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getnetworkinfo`
      end
      
      def get_peer_info
        # Returns data about each connected network node as a json array of objects.
        # 
        # Result:
        # [
        #   {
        #     "id": n,                   (numeric) Peer index
        #     "addr":"host:port",      (string) The ip address and port of the peer
        #     "addrlocal":"ip:port",   (string) local address
        #     "services":"xxxxxxxxxxxxxxxx",   (string) The services offered
        #     "relaytxes":true|false,    (boolean) Whether peer has asked us to relay transactions to it
        #     "lastsend": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last send
        #     "lastrecv": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last receive
        #     "bytessent": n,            (numeric) The total bytes sent
        #     "bytesrecv": n,            (numeric) The total bytes received
        #     "conntime": ttt,           (numeric) The connection time in seconds since epoch (Jan 1 1970 GMT)
        #     "timeoffset": ttt,         (numeric) The time offset in seconds
        #     "pingtime": n,             (numeric) ping time
        #     "minping": n,              (numeric) minimum observed ping time
        #     "pingwait": n,             (numeric) ping wait
        #     "version": v,              (numeric) The peer version, such as 7001
        #     "subver": "/Satoshi:0.8.5/",  (string) The string version
        #     "inbound": true|false,     (boolean) Inbound (true) or Outbound (false)
        #     "startingheight": n,       (numeric) The starting height (block) of the peer
        #     "banscore": n,             (numeric) The ban score
        #     "synced_headers": n,       (numeric) The last header we have in common with this peer
        #     "synced_blocks": n,        (numeric) The last block we have in common with this peer
        #     "inflight": [
        #        n,                        (numeric) The heights of blocks we're currently asking from this peer
        #        ...
        #     ]
        #   }
        #   ,...
        # ]
        # 
        # Examples:
        # > bitcoin-cli getpeerinfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpeerinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getpeerinfo`
      end
      
      def list_banned
        # List all banned IPs/Subnets.
        # 
        # Examples:
        # > bitcoin-cli listbanned
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli listbanned`
      end
      
      def ping
        # Requests that a ping be sent to all other nodes, to measure ping time.
        # Results provided in getpeerinfo, pingtime and pingwait fields are decimal seconds.
        # Ping command is handled in queue with all other commands, so it measures processing backlog, not just network ping.
        # 
        # Examples:
        # > bitcoin-cli ping
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "ping", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli ping`
      end
      
      def set_ban ip, type, bantime, absolute
        # Attempts add or remove a IP/Subnet from the banned list.
        # 
        # Arguments:
        # 1. "ip(/netmask)" (string, required) The IP/Subnet (see getpeerinfo for nodes ip) with a optional netmask (default is /32 = single ip)
        # 2. "command"      (string, required) 'add' to add a IP/Subnet to the list, 'remove' to remove a IP/Subnet from the list
        # 3. "bantime"      (numeric, optional) time in seconds how long (or until when if [absolute] is set) the ip is banned (0 or empty means using the default time of 24h which can also be overwritten by the -bantime startup argument)
        # 4. "absolute"     (boolean, optional) If set, the bantime must be a absolute timestamp in seconds since epoch (Jan 1 1970 GMT)
        # 
        # Examples:
        # > bitcoin-cli setban "192.168.0.6" "add" 86400
        # > bitcoin-cli setban "192.168.0.0/24" "add"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setban", "params": ["192.168.0.6", "add" 86400] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli setban #{ip} #{type} #{bantime} #{absolute}`
      end
    end
  end
end
