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
      
      def get_block hash, verbose
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
     
        `bitcoin-cli getblock #{hash} #{verbose}`
      end
      
      def get_info
        `bitcoin-cli getinfo`
      end
      # getblockchaininfo
      # getblockcount
      # getblockhash index
      # getblockheader "hash" ( verbose )
      # getchaintips
      # getdifficulty
      # getmempoolinfo
      # getrawmempool ( verbose )
      # gettxout "txid" n ( includemempool )
      # gettxoutproof ["txid",...] ( blockhash )
      # gettxoutsetinfo
      # verifychain ( checklevel numblocks )
      # verifytxoutproof "proof"
    end
  end
end
