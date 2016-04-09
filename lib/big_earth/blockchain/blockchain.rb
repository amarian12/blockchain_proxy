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
      
      def get_block_header hash
        # If verbose is false, returns a string that is serialized, hex-encoded data for blockheader 'hash'.
        # If verbose is true, returns an Object with information about blockheader <hash>.
        # 
        # Arguments:
        # 1. "hash"          (string, required) The block hash
        # 2. verbose           (boolean, optional, default=true) true for a json object, false for the hex encoded data
        # 
        # Result (for verbose = true):
        # {
        #   "hash" : "hash",     (string) the block hash (same as provided)
        #   "confirmations" : n,   (numeric) The number of confirmations, or -1 if the block is not on the main chain
        #   "height" : n,          (numeric) The block height or index
        #   "version" : n,         (numeric) The block version
        #   "merkleroot" : "xxxx", (string) The merkle root
        #   "time" : ttt,          (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)
        #   "mediantime" : ttt,    (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)
        #   "nonce" : n,           (numeric) The nonce
        #   "bits" : "1d00ffff", (string) The bits
        #   "difficulty" : x.xxx,  (numeric) The difficulty
        #   "previousblockhash" : "hash",  (string) The hash of the previous block
        #   "nextblockhash" : "hash",      (string) The hash of the next block
        #   "chainwork" : "0000...1f3"     (string) Expected number of hashes required to produce the current chain (in hex)
        # }
        # 
        # Result (for verbose=false):
        # "data"             (string) A string that is serialized, hex-encoded data for block 'hash'.
        # 
        # Examples:
        # > bitcoin-cli getblockheader "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockheader", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getblockheader #{hash}`
      end
      
      def get_chain_tips
        # Return information about all known tips in the block tree, including the main chain as well as orphaned branches.
        # Result:
        # [
        #   {
        #     "height": xxxx,         (numeric) height of the chain tip
        #     "hash": "xxxx",         (string) block hash of the tip
        #     "branchlen": 0          (numeric) zero for main chain
        #     "status": "active"      (string) "active" for the main chain
        #   },
        #   {
        #     "height": xxxx,
        #     "hash": "xxxx",
        #     "branchlen": 1          (numeric) length of branch connecting the tip to the main chain
        #     "status": "xxxx"        (string) status of the chain (active, valid-fork, valid-headers, headers-only, invalid)
        #   }
        # ]
        # Possible values for status:
        # 1.  "invalid"               This branch contains at least one invalid block
        # 2.  "headers-only"          Not all blocks for this branch are available, but the headers are valid
        # 3.  "valid-headers"         All blocks are available for this branch, but they were never fully validated
        # 4.  "valid-fork"            This branch is not part of the active chain, but is fully validated
        # 5.  "active"                This is the tip of the active main chain, which is certainly valid
        # 
        # Examples:
        # > bitcoin-cli getchaintips
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintips", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getchaintips`
       end
      
      def get_difficulty
        # Returns the proof-of-work difficulty as a multiple of the minimum difficulty.
        # 
        # Result:
        # n.nnn       (numeric) the proof-of-work difficulty as a multiple of the minimum difficulty.
        # 
        # Examples:
        # > bitcoin-cli getdifficulty
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getdifficulty", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getdifficulty`
      end
      
      def get_mem_pool_info
        # Returns details on the active state of the TX memory pool.
        # 
        # Result:
        # {
        #   "size": xxxxx,               (numeric) Current tx count
        #   "bytes": xxxxx,              (numeric) Sum of all tx sizes
        #   "usage": xxxxx,              (numeric) Total memory usage for the mempool
        #   "maxmempool": xxxxx,         (numeric) Maximum memory usage for the mempool
        #   "mempoolminfee": xxxxx       (numeric) Minimum fee for tx to be accepted
        # }
        # 
        # Examples:
        # > bitcoin-cli getmempoolinfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getmempoolinfo`
      end
      
      def get_raw_mem_pool
        # Returns all transaction ids in memory pool as a json array of string transaction ids.
        # 
        # Arguments:
        # 1. verbose           (boolean, optional, default=false) true for a json object, false for array of transaction ids
        # 
        # Result: (for verbose = false):
        # [                     (json array of string)
        #   "transactionid"     (string) The transaction id
        #   ,...
        # ]
        # 
        # Result: (for verbose = true):
        # {                           (json object)
        #   "transactionid" : {       (json object)
        #     "size" : n,             (numeric) transaction size in bytes
        #     "fee" : n,              (numeric) transaction fee in BTC
        #     "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority
        #     "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT
        #     "height" : n,           (numeric) block height when transaction entered pool
        #     "startingpriority" : n, (numeric) priority when transaction entered pool
        #     "currentpriority" : n,  (numeric) transaction priority now
        #     "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)
        #     "descendantsize" : n,   (numeric) size of in-mempool descendants (including this one)
        #     "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one)
        #     "depends" : [           (array) unconfirmed transactions used as inputs for this transaction
        #         "transactionid",    (string) parent transaction id
        #      ]
        #   },
        # }
        # 
        # Examples
        # > bitcoin-cli getrawmempool true
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawmempool", "params": [true] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getrawmempool true`
      end
      
      def get_tx_out n 
        # Returns details about an unspent transaction output.
        # 
        # Arguments:
        # 1. "txid"       (string, required) The transaction id
        # 2. n              (numeric, required) vout value
        # 3. includemempool  (boolean, optional) Whether to included the mem pool
        # 
        # Result:
        # {
        #   "bestblock" : "hash",    (string) the block hash
        #   "confirmations" : n,       (numeric) The number of confirmations
        #   "value" : x.xxx,           (numeric) The transaction value in BTC
        #   "scriptPubKey" : {         (json object)
        #      "asm" : "code",       (string)
        #      "hex" : "hex",        (string)
        #      "reqSigs" : n,          (numeric) Number of required signatures
        #      "type" : "pubkeyhash", (string) The type, eg pubkeyhash
        #      "addresses" : [          (array of string) array of bitcoin addresses
        #        "bitcoinaddress"     (string) bitcoin address
        #      ]
        #   },
        #   "version" : n,            (numeric) The version
        #   "coinbase" : true|false   (boolean) Coinbase or not
        # }
        # 
        # Examples:
        # 
        # Get unspent transactions
        # > bitcoin-cli listunspent
        # 
        # View the details
        # > bitcoin-cli gettxout "txid" 1
        # 
        # As a json rpc call
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxout", "params": ["txid", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli gettxout "txid" #{n}`
      end
      
      def get_tx_out_proof txid, blockhash
        # Returns a hex-encoded proof that "txid" was included in a block.
        # 
        # NOTE: By default this function only works sometimes. This is when there is an
        # unspent output in the utxo for this transaction. To make it always work,
        # you need to maintain a transaction index, using the -txindex command line option or
        # specify the block in which the transaction is included in manually (by blockhash).
        # 
        # Return the raw transaction data.
        # 
        # Arguments:
        # 1. "txids"       (string) A json array of txids to filter
        #     [
        #       "txid"     (string) A transaction hash
        #       ,...
        #     ]
        # 2. "block hash"  (string, optional) If specified, looks for txid in the block with this hash
        # 
        # Result:
        # "data"           (string) A string that is a serialized, hex-encoded data for the proof.
        #gettxoutproof ["txid",...] ( blockhash )
      end
      
      def get_tx_outset_info
        # Returns statistics about the unspent transaction output set.
        # Note this call may take some time.
        # 
        # Result:
        # {
        #   "height":n,     (numeric) The current block height (index)
        #   "bestblock": "hex",   (string) the best block hash hex
        #   "transactions": n,      (numeric) The number of transactions
        #   "txouts": n,            (numeric) The number of output transactions
        #   "bytes_serialized": n,  (numeric) The serialized size
        #   "hash_serialized": "hash",   (string) The serialized hash
        #   "total_amount": x.xxx          (numeric) The total amount
        # }
        # 
        # Examples:
        # > bitcoin-cli gettxoutsetinfo
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxoutsetinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli gettxoutsetinfo`
      end
      
      def verify_chain checklevel, numblocks
        # Verifies blockchain database.
        # 
        # Arguments:
        # 1. checklevel   (numeric, optional, 0-4, default=3) How thorough the block verification is.
        # 2. numblocks    (numeric, optional, default=288, 0=all) The number of blocks to check.
        # 
        # Result:
        # true|false       (boolean) Verified or not
        # 
        # Examples:
        # > bitcoin-cli verifychain
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifychain", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli verifychain`
        #  ( checklevel numblocks )
      end
      
      def verify_tx_out_proof proof
        # Verifies that a proof points to a transaction in a block, returning the transaction it commits to and throwing an RPC error if the block is not in our best chain
        # 
        # Arguments:
        # 1. "proof"    (string, required) The hex-encoded proof generated by gettxoutproof
        # 
        # Result:
        # ["txid"]      (array, strings) The txid(s) which the proof commits to, or empty array if the proof is invalid
        `bitcoin-cli verifytxoutproof #{proof}`
      end
    end
  end
end
