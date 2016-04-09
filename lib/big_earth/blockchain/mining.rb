module BigEarth 
  module Blockchain 
    class Mining
      def get_block_template jsonrequestobject
        # If the request parameters include a 'mode' key, that is used to explicitly select between the default 'template' request or a 'proposal'. 
        # It returns data needed to construct a block to work on.
        # See https://en.bitcoin.it/wiki/BIP_0022 for full specification.
        # 
        # Arguments:
        # 1. "jsonrequestobject"       (string, optional) A json object in the following spec
        #      {
        #        "mode":"template"    (string, optional) This must be set to "template" or omitted
        #        "capabilities":[       (array, optional) A list of strings
        #            "support"           (string) client side supported feature, 'longpoll', 'coinbasetxn', 'coinbasevalue', 'proposal', 'serverlist', 'workid'
        #            ,...
        #          ]
        #      }
        # 
        # 
        # Result:
        # {
        #   "version" : n,                    (numeric) The block version
        #   "previousblockhash" : "xxxx",    (string) The hash of current highest block
        #   "transactions" : [                (array) contents of non-coinbase transactions that should be included in the next block
        #     {
        #    "data" : "xxxx",          (string) transaction data encoded in hexadecimal (byte-for-byte)
        #    "hash" : "xxxx",          (string) hash/id encoded in little-endian hexadecimal
        #    "depends" : [              (array) array of numbers
        #        n                        (numeric) transactions before this one (by 1-based index in 'transactions' list) that must be present in the final block if this one is
        #        ,...
        #    ],
        #    "fee": n,                   (numeric) difference in value between transaction inputs and outputs (in Satoshis); for coinbase transactions, this is a negative Number of t$
        # e total collected block fees (ie, not including the block subsidy); if key is not present, fee is unknown and clients MUST NOT assume there isn't one
        #    "sigops" : n,               (numeric) total number of SigOps, as counted for purposes of block limits; if key is not present, sigop count is unknown and clients MUST NOT
        # assume there aren't any
        #    "required" : true|false     (boolean) if provided and true, this transaction must be in the final block
        # }
        # ,...
        # ],
        # "coinbaseaux" : {                  (json object) data that should be included in the coinbase's scriptSig content
        # "flags" : "flags"            (string)
        # },
        # "coinbasevalue" : n,               (numeric) maximum allowable input to coinbase transaction, including the generation award and transaction fees (in Satoshis)
        # "coinbasetxn" : { ... },           (json object) information for coinbase transaction
        # "target" : "xxxx",               (string) The hash target
        # "mintime" : xxx,                   (numeric) The minimum timestamp appropriate for next block time in seconds since epoch (Jan 1 1970 GMT)
        # "mutable" : [                      (array of string) list of ways the block template may be changed
        #    "value"                         (string) A way the block template may be changed, e.g. 'time', 'transactions', 'prevblock'
        #    ,...
        # ],
        # "noncerange" : "00000000ffffffff",   (string) A range of valid nonces
        # "sigoplimit" : n,                 (numeric) limit of sigops in blocks
        # "sizelimit" : n,                  (numeric) limit of block size
        # "curtime" : ttt,                  (numeric) current timestamp in seconds since epoch (Jan 1 1970 GMT)
        # "bits" : "xxx",                 (string) compressed target of next block
        # "height" : n                      (numeric) The height of the next block
        # }
        # 
        # Examples:
        # > bitcoin-cli getblocktemplate
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblocktemplate", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getblocktemplate #{jsonrequestobject}`
      end
      
      def get_mining_info
        # Returns a json object containing mining-related information.
        # Result:
        # {
        #   "blocks": nnn,             (numeric) The current block
        #   "currentblocksize": nnn,   (numeric) The last block size
        #   "currentblocktx": nnn,     (numeric) The last block transaction
        #   "difficulty": xxx.xxxxx    (numeric) The current difficulty
        #   "errors": "..."          (string) Current errors
        #   "generate": true|false     (boolean) If the generation is on or off (see getgenerate or setgenerate calls)
        #   "genproclimit": n          (numeric) The processor limit for generation. -1 if no generation. (see getgenerate or setgenerate calls)
        #   "pooledtx": n              (numeric) The size of the mem pool
        #   "testnet": true|false      (boolean) If using testnet or not
        #   "chain": "xxxx",         (string) current network name as defined in BIP70 (main, test, regtest)
        # }
        # 
        # Examples:
        # > bitcoin-cli getmininginfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmininginfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getmininginfo`
      end
      
      def get_network_hashps blocks, height
        # Returns the estimated network hashes per second based on the last n blocks.
        # Pass in [blocks] to override # of blocks, -1 specifies since last difficulty change.
        # Pass in [height] to estimate the network speed at the time when a certain block was found.
        # 
        # Arguments:
        # 1. blocks     (numeric, optional, default=120) The number of blocks, or -1 for blocks since last difficulty change.
        # 2. height     (numeric, optional, default=-1) To estimate at the time of the given height.
        # 
        # Result:
        # x             (numeric) Hashes per second estimated
        # 
        # Examples:
        # > bitcoin-cli getnetworkhashps
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkhashps", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getnetworkhashps #{blocks} #{height}`
      end
      
      def prioritise_transaction txid, priority_delta, fee_delta
      # Accepts the transaction into mined blocks at a higher (or lower) priority
      # 
      # Arguments:
      # 1. "txid"       (string, required) The transaction id.
      # 2. priority delta (numeric, required) The priority to add or subtract.
      #                   The transaction selection algorithm considers the tx as it would have a higher priority.
      #                   (priority of a transaction is calculated: coinage * value_in_satoshis / txsize)
      # 3. fee delta      (numeric, required) The fee value (in satoshis) to add (or subtract, if negative).
      #                   The fee is not actually paid, only the algorithm for selecting transactions into a block
      #                   considers the transaction as it would have paid a higher (or lower) fee.
      # 
      # Result
      # true              (boolean) Returns true
      # 
      # Examples:
      # > bitcoin-cli prioritisetransaction "txid" 0.0 10000
      # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "prioritisetransaction", "params": ["txid", 0.0, 10000] }' -H 'content-type: text/plain;' htt
      # p://127.0.0.1:8332/
        `bitcoin-cli prioritisetransaction #{txid} #{priority_delta} #{fee_delta}`
      end
      
      def submit_block hexdata, jsonparametersobject
        # Attempts to submit new block to network.
        # The 'jsonparametersobject' parameter is currently ignored.
        # See https://en.bitcoin.it/wiki/BIP_0022 for full specification.
        # 
        # Arguments
        # 1. "hexdata"    (string, required) the hex-encoded block data to submit
        # 2. "jsonparametersobject"     (string, optional) object of optional parameters
        #     {
        #       "workid" : "id"    (string, optional) if the server provided a workid, it MUST be included with submissions
        #     }
        # 
        # Result:
        # 
        # Examples:
        # > bitcoin-cli submitblock "mydata"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "submitblock", "params": ["mydata"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli submitblock #{hexdata} #{jsonparametersobject}`
      end
    end
  end
end
