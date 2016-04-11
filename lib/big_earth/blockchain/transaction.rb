module BigEarth 
  module Blockchain 
    class Transaction
      def create_raw_transaction txid, address
        # Create a transaction spending the given inputs and creating new outputs.
        # Outputs can be addresses or data.
        # Returns hex-encoded raw transaction.
        # Note that the transaction's inputs are not signed, and
        # it is not stored in the wallet or transmitted to the network.
        # 
        # Arguments:
        # 1. "transactions"        (string, required) A json array of json objects
        #      [
        #        {
        #          "txid":"id",    (string, required) The transaction id
        #          "vout":n        (numeric, required) The output number
        #        }
        #        ,...
        #      ]
        # 2. "outputs"             (string, required) a json object with outputs
        #     {
        #       "address": x.xxx   (numeric or string, required) The key is the bitcoin address, the numeric value (can be string) is the BTC amount
        #       "data": "hex",     (string, required) The key is "data", the value is hex encoded data
        #       ...
        #     }
        # 3. locktime                (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs
        # 
        # Result:
        # "transaction"            (string) hex string of the transaction
        # 
        # Examples
        # > bitcoin-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "{\"address\":0.01}"
        # > bitcoin-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "{\"data\":\"00010203\"}"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "{\"address\":0.01}"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "{\"data\":\"00010203\"}"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli createrawtransaction #{txid} #{address}`
      end
      
      def decode_raw_transaction hexstring
        # Return a JSON object representing the serialized, hex-encoded transaction.
        # 
        # Arguments:
        # 1. "hex"      (string, required) The transaction hex string
        # 
        # Result:
        # {
        #   "txid" : "id",        (string) The transaction id
        #   "size" : n,             (numeric) The transaction size
        #   "version" : n,          (numeric) The version
        #   "locktime" : ttt,       (numeric) The lock time
        #   "vin" : [               (array of json objects)
        #      {
        #        "txid": "id",    (string) The transaction id
        #        "vout": n,         (numeric) The output number
        #        "scriptSig": {     (json object) The script
        #          "asm": "asm",  (string) asm
        #          "hex": "hex"   (string) hex
        #        },
        #        "sequence": n     (numeric) The script sequence number
        #      }
        #      ,...
        #   ],
        #   "vout" : [             (array of json objects)
        #      {
        #        "value" : x.xxx,            (numeric) The value in BTC
        #        "n" : n,                    (numeric) index
        #        "scriptPubKey" : {          (json object)
        #          "asm" : "asm",          (string) the asm
        #          "hex" : "hex",          (string) the hex
        #          "reqSigs" : n,            (numeric) The required sigs
        #          "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'
        #          "addresses" : [           (json array of string)
        #            "12tvKAXCxZjSmdNbao16dKXC8tRWfcF5oc"   (string) bitcoin address
        #            ,...
        #          ]
        #        }
        #      }
        #      ,...
        #   ],
        # }
        # Examples:
        # > bitcoin-cli decoderawtransaction "hexstring"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decoderawtransaction", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli decoderawtransaction #{hexstring}`
      end
      
      def decode_script hex
        # Decode a hex-encoded script.
        # 
        # Arguments:
        # 1. "hex"     (string) the hex encoded script
        # 
        # Result:
        # {
        #   "asm":"asm",   (string) Script public key
        #   "hex":"hex",   (string) hex encoded public key
        #   "type":"type", (string) The output type
        #   "reqSigs": n,    (numeric) The required signatures
        #   "addresses": [   (json array of string)
        #      "address"     (string) bitcoin address
        #      ,...
        #   ],
        #   "p2sh","address" (string) script address
        # }
        # 
        # Examples:
        # > bitcoin-cli decodescript "hexstring"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decodescript", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli decodescript`
      end
      
      def get_raw_transaction txid
        # NOTE: By default this function only works sometimes. This is when the tx is in the mempool
        # or there is an unspent output in the utxo for this transaction. To make it always work,
        # you need to maintain a transaction index, using the -txindex command line option.
        # 
        # Return the raw transaction data.
        # 
        # If verbose=0, returns a string that is serialized, hex-encoded data for 'txid'.
        # If verbose is non-zero, returns an Object with information about 'txid'.
        # 
        # Arguments:
        # 1. "txid"      (string, required) The transaction id
        # 2. verbose       (numeric, optional, default=0) If 0, return a string, other return a json object
        # 
        # Result (if verbose is not set or set to 0):
        # "data"      (string) The serialized, hex-encoded data for 'txid'
        # 
        # Result (if verbose > 0):
        # {
        #   "hex" : "data",       (string) The serialized, hex-encoded data for 'txid'
        #   "txid" : "id",        (string) The transaction id (same as provided)
        #   "size" : n,             (numeric) The transaction size
        #   "version" : n,          (numeric) The version
        #   "locktime" : ttt,       (numeric) The lock time
        #   "vin" : [               (array of json objects)
        #      {
        #        "txid": "id",    (string) The transaction id
        #        "vout": n,         (numeric)
        #        "scriptSig": {     (json object) The script
        #          "asm": "asm",  (string) asm
        #          "hex": "hex"   (string) hex
        #        },
        #        "sequence": n      (numeric) The script sequence number
        #      }
        #      ,...
        #   ],
        #   "vout" : [              (array of json objects)
        #      {
        #        "value" : x.xxx,            (numeric) The value in BTC
        #        "n" : n,                    (numeric) index
        #        "scriptPubKey" : {          (json object)
        #          "asm" : "asm",          (string) the asm
        #          "hex" : "hex",          (string) the hex
        #          "reqSigs" : n,            (numeric) The required sigs
        #          "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'
        #          "addresses" : [           (json array of string)
        #            "bitcoinaddress"        (string) bitcoin address
        #            ,...
        #         ]
        #       }
        #     }
        #     ,...
        #   ],
        #   "blockhash" : "hash",   (string) the block hash
        #   "confirmations" : n,      (numeric) The confirmations
        #   "time" : ttt,             (numeric) The transaction time in seconds since epoch (Jan 1 1970 GMT)
        #   "blocktime" : ttt         (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)
        # }
        # 
        # Examples:
        # > bitcoin-cli getrawtransaction "mytxid"
        # > bitcoin-cli getrawtransaction "mytxid" 1
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawtransaction", "params": ["mytxid", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli getrawtransaction #{txid}`
      end
      
      def send_raw_transaction hexstring
        # Submits raw transaction (serialized, hex-encoded) to local node and network.
        # 
        # Also see createrawtransaction and signrawtransaction calls.
        # 
        # Arguments:
        # 1. "hexstring"    (string, required) The hex string of the raw transaction)
        # 2. allowhighfees    (boolean, optional, default=false) Allow high fees
        # 
        # Result:
        # "hex"             (string) The transaction hash in hex
        # 
        # Examples:
        # 
        # Create a transaction
        # > bitcoin-cli createrawtransaction "[{\"txid\" : \"mytxid\",\"vout\":0}]" "{\"myaddress\":0.01}"
        # Sign the transaction, and get back the hex
        # > bitcoin-cli signrawtransaction "myhex"
        # 
        # Send the transaction (signed hex)
        # > bitcoin-cli sendrawtransaction "signedhex"
        # 
        # As a json rpc call
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendrawtransaction", "params": ["signedhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli sendrawtransaction #{hexstring}`
      end
      
      def sign_raw_transaction hexstring
        # Sign inputs for raw transaction (serialized, hex-encoded).
        # The second optional argument (may be null) is an array of previous transaction outputs that
        # this transaction depends on but may not yet be in the block chain.
        # The third optional argument (may be null) is an array of base58-encoded private
        # keys that, if given, will be the only keys used to sign the transaction.
        # 
        # Arguments:
        # 1. "hexstring"     (string, required) The transaction hex string
        # 2. "prevtxs"       (string, optional) An json array of previous dependent transaction outputs
        #      [               (json array of json objects, or 'null' if none provided)
        #        {
        #          "txid":"id",             (string, required) The transaction id
        #          "vout":n,                  (numeric, required) The output number
        #          "scriptPubKey": "hex",   (string, required) script key
        #          "redeemScript": "hex"    (string, required for P2SH) redeem script
        #        }
        #        ,...
        #     ]
        # 3. "privatekeys"     (string, optional) A json array of base58-encoded private keys for signing
        #     [                  (json array of strings, or 'null' if none provided)
        #       "privatekey"   (string) private key in base58-encoding
        #       ,...
        #     ]
        # 4. "sighashtype"     (string, optional, default=ALL) The signature hash type. Must be one of
        #        "ALL"
        #        "NONE"
        #        "SINGLE"
        #        "ALL|ANYONECANPAY"
        #        "NONE|ANYONECANPAY"
        #        "SINGLE|ANYONECANPAY"
        # 
        # Result:
        # {
        #   "hex" : "value",           (string) The hex-encoded raw transaction with signature(s)
        #   "complete" : true|false,   (boolean) If the transaction has a complete set of signatures
        #   "errors" : [                 (json array of objects) Script verification errors (if there are any)
        #     {
        #       "txid" : "hash",           (string) The hash of the referenced, previous transaction
        #       "vout" : n,                (numeric) The index of the output to spent and used as input
        #       "scriptSig" : "hex",       (string) The hex-encoded signature script
        #       "sequence" : n,            (numeric) Script sequence number
        #       "error" : "text"           (string) Verification or signing error related to the input
        #     }
        #   ,...
        #   ]
        # }
        # 
        # Examples:
        # > bitcoin-cli signrawtransaction "myhex"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransaction", "params": ["myhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli signrawtransaction #{hexstring}`
      end
    end
  end
end
