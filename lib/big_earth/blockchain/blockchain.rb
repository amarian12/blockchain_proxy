module BigEarth 
  module Blockchain 
    class Blockchain
      def initialize 
      end
      
      def get_best_block_hash
        # Returns the hash of the best (tip) block in the longest block chain.
        # Result "hex" (string) the block hash hex encoded

        # Examples
        # > bitcoin-cli getbestblockhash
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbestblockhash", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getbestblockhash`
      end
      
      def get_block hash
        # 
        # If verbose is false, returns a string that is serialized, hex-encoded data for block 'hash'.
        # If verbose is true, returns an Object with information about block <hash>.
        # 
        # Arguments:
        # 1. "hash"          (string, required) The block hash
        # 2. verbose           (boolean, optional, default=true) true for a json object, false for the hex encoded data
        # 
        # Result (for verbose = true):
        # {
        #   "hash" : "hash",     (string) the block hash (same as provided)
        #   "confirmations" : n,   (numeric) The number of confirmations, or -1 if the block is not on the main chain
        #   "size" : n,            (numeric) The block size
        #   "height" : n,          (numeric) The block height or index
        #   "version" : n,         (numeric) The block version
        #   "merkleroot" : "xxxx", (string) The merkle root
        #   "tx" : [               (array of string) The transaction ids
        #      "transactionid"     (string) The transaction id
        #      ], 
        #   "time" : ttt,          (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)
        #   "mediantime" : ttt,    (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)
        #   "nonce" : n,           (numeric) The nonce
        #   "bits" : "1d00ffff", (string) The bits
        #   "difficulty" : x.xxx,  (numeric) The difficulty
        #   "chainwork" : "xxxx",  (string) Expected number of hashes required to produce the chain up to this block (in hex)
        #   "previousblockhash" : "hash",  (string) The hash of the previous block
        #   "nextblockhash" : "hash"       (string) The hash of the next block
        # }
        # 
        # Result (for verbose=false):
        # "data"             (string) A string that is serialized, hex-encoded data for block 'hash'.
        # 
        # Examples:
        # > bitcoin-cli getblock "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblock", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' - H 'content-type: text/plain;' http://127.0.0.1:8332/
     
        `bitcoin-cli getblock #{hash}`
      end
      
      def get_block_chain_info
        # Returns an object containing various state info regarding block chain processing.
        # 
        # Result:
        # {
        #   "chain": "xxxx",        (string) current network name as defined in BIP70 (main, test, regtest)
        #   "blocks": xxxxxx,         (numeric) the current number of blocks processed in the server
        #   "headers": xxxxxx,        (numeric) the current number of headers we have validated
        #   "bestblockhash": "...", (string) the hash of the currently best block
        #   "difficulty": xxxxxx,     (numeric) the current difficulty
        #   "mediantime": xxxxxx,     (numeric) median time for the current best block
        #   "verificationprogress": xxxx, (numeric) estimate of verification progress [0..1]
        #   "chainwork": "xxxx"     (string) total amount of work in active chain, in hexadecimal
        #   "pruned": xx,             (boolean) if the blocks are subject to pruning
        #   "pruneheight": xxxxxx,    (numeric) heighest block available
        #   "softforks": [            (array) status of softforks in progress
        #     {
        #       "id": "xxxx",        (string) name of softfork
        #       "version": xx,         (numeric) block version
        #       "enforce": {           (object) progress toward enforcing the softfork rules for new-version blocks
        #         "status": xx,       (boolean) true if threshold reached
        #         "found": xx,        (numeric) number of blocks with the new version found
        #         "required": xx,     (numeric) number of blocks required to trigger
        #         "window": xx,       (numeric) maximum size of examined window of recent blocks
        #       },
        #       "reject": { ... }      (object) progress toward rejecting pre-softfork blocks (same fields as "enforce")
        #     }, ...
        #   ]
        # }
        # 
        # Examples:
        # > bitcoin-cli getblockchaininfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getblockchaininfo`
      end
      
      def get_info
        # Returns an object containing various state info.
        # Result:
        #   {
        #     "version": xxxxx,           (numeric) the server version
        #     "protocolversion": xxxxx,   (numeric) the protocol version
        #     "walletversion": xxxxx,     (numeric) the wallet version
        #     "balance": xxxxxxx,         (numeric) the total bitcoin balance of the wallet
        #     "blocks": xxxxxx,           (numeric) the current number of blocks processed in the server
        #     "timeoffset": xxxxx,        (numeric) the time offset
        #     "connections": xxxxx,       (numeric) the number of connections
        #     "proxy": "host:port",     (string, optional) the proxy used by the server
        #     "difficulty": xxxxxx,       (numeric) the current difficulty
        #     "testnet": true|false,      (boolean) if the server is using testnet or not
        #     "keypoololdest": xxxxxx,    (numeric) the timestamp (seconds since GMT epoch) of the oldest pre-generated key in the key pool
        #     "keypoolsize": xxxx,        (numeric) how many new keys are pre-generated
        #     "unlocked_until": ttt,      (numeric) the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked
        #     "paytxfee": x.xxxx,         (numeric) the transaction fee set in BTC/kB
        #     "relayfee": x.xxxx,         (numeric) minimum relay fee for non-free transactions in BTC/kB
        #     "errors": "..."           (string) any error messages
        #   }
        # 
        # Examples:
        # > bitcoin-cli getinfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getinfo`
      end
      
      def get_block_count
        # Returns the number of blocks in the longest block chain.
        # 
        # Result:
        # n    (numeric) The current block count
        # 
        # Examples:
        # > bitcoin-cli getblockcount
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockcount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getblockcount`
      end
      
      def get_block_hash index
        # Returns hash of block in best-block-chain at index provided.
        # 
        # Arguments:
        # 1. index         (numeric, required) The block index
        # 
        # Result:
        # "hash"         (string) The block hash
        # 
        # Examples:
        # > bitcoin-cli getblockhash 1000
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockhash", "params": [1000] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getblockhash #{index}`
      end
      
      def getblockheader hash, verbose
      # getblockheader "hash" ( verbose )
      end
      
      def getchaintips
      # getchaintips
      end
      
      def getdifficulty
      # getdifficulty
      end
      
      def getmempoolinfo
      # getmempoolinfo
      end
      
      def getrawmempool verbose
      # getrawmempool ( verbose )
      end
      
      def gettxout txid, n, includemempool
      # gettxout "txid" n ( includemempool )
      end
      
      def gettxoutproof txid, blockhash
      # gettxoutproof ["txid",...] ( blockhash )
      end
      
      def gettxoutsetinfo
      # gettxoutsetinfo
      end
      
      def verifychain checklevel, numblocks
      # verifychain ( checklevel numblocks )
      end
      
      def verifytxoutproof proof
      # verifytxoutproof "proof"
      end
    end
  end
end
