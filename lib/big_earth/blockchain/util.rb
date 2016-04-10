module BigEarth 
  module Blockchain 
    class Util
      def create_multi_sig nrequired
        # Creates a multi-signature address with n signature of m keys required.
        # It returns a json object with the address and redeemScript.
        # 
        # Arguments:
        # 1. nrequired      (numeric, required) The number of required signatures out of the n keys or addresses.
        # 2. "keys"       (string, required) A json array of keys which are bitcoin addresses or hex-encoded public keys
        #      [
        #        "key"    (string) bitcoin address or hex-encoded public key
        #        ,...
        #      ]
        # 
        # Result:
        # {
        #   "address":"multisigaddress",  (string) The value of the new multisig address.
        #   "redeemScript":"script"       (string) The string value of the hex-encoded redemption script.
        # }
        # 
        # Examples:
        # 
        # Create a multisig address from 2 addresses
        # > bitcoin-cli createmultisig 2 "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"
        # 
        # As a json rpc call
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2, "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli createmultisig #{nrequired}`
      end
      
      def estimate_fee nblocks
        # Estimates the approximate fee per kilobyte needed for a transaction to begin
        # confirmation within nblocks blocks.
        # 
        # Arguments:
        # 1. nblocks     (numeric)
        # 
        # Result:
        # n              (numeric) estimated fee-per-kilobyte
        # 
        # A negative value is returned if not enough transactions and blocks
        # have been observed to make an estimate.
        # 
        # Example:
        # > bitcoin-cli estimatefee 6
        `bitcoin-cli estimatefee #{nblocks}`
      end
      
      def estimate_priority nblocks
        # Estimates the approximate priority a zero-fee transaction needs to begin confirmation within nblocks blocks.
        # 
        # Arguments:
        # 1. nblocks     (numeric)
        # 
        # Result:
        # n              (numeric) estimated priority
        # 
        # A negative value is returned if not enough transactions and blocks
        # have been observed to make an estimate.
        # 
        # Example:
        # > bitcoin-cli estimatepriority 6
        `bitcoin-cli estimatepriority #{nblocks}`
      end
      
      def estimate_smart_fee nblocks
        # WARNING: This interface is unstable and may disappear or change!
        # 
        # Estimates the approximate fee per kilobyte needed for a transaction to begin
        # confirmation within nblocks blocks if possible and return the number of blocks
        # for which the estimate is valid.
        # 
        # Arguments:
        # 1. nblocks     (numeric)
        # 
        # Result:
        # {
        #   "feerate" : x.x,     (numeric) estimate fee-per-kilobyte (in BTC)
        #   "blocks" : n         (numeric) block number where estimate was found
        # }
        # 
        # A negative value is returned if not enough transactions and blocks
        # have been observed to make an estimate for any number of blocks.
        # However it will not return a value below the mempool reject fee.
        # 
        # Example:
        # > bitcoin-cli estimatesmartfee 6
        `bitcoin-cli estimatesmartfee #{nblocks}`
      end
      
      def estimate_smart_priority nblocks
        # WARNING: This interface is unstable and may disappear or change!
        # 
        # Estimates the approximate priority a zero-fee transaction needs to begin
        # confirmation within nblocks blocks if possible and return the number of blocks
        # for which the estimate is valid.
        # 
        # Arguments:
        # 1. nblocks     (numeric)
        # 
        # Result:
        # {
        #   "priority" : x.x,    (numeric) estimated priority
        #   "blocks" : n         (numeric) block number where estimate was found
        # }
        # 
        # A negative value is returned if not enough transactions and blocks
        # have been observed to make an estimate for any number of blocks.
        # However if the mempool reject fee is set it will return 1e9 * MAX_MONEY.
        # 
        # Example:
        # > bitcoin-cli estimatesmartpriority 6
        `bitcoin-cli estimatesmartpriority #{nblocks}`
      end
      
      def validate_address bitcoinaddress
        # Return information about the given bitcoin address.
        # 
        # Arguments:
        # 1. "bitcoinaddress"     (string, required) The bitcoin address to validate
        # 
        # Result:
        # {
        #   "isvalid" : true|false,       (boolean) If the address is valid or not. If not, this is the only property returned.
        #   "address" : "bitcoinaddress", (string) The bitcoin address validated
        #   "scriptPubKey" : "hex",       (string) The hex encoded scriptPubKey generated by the address
        #   "ismine" : true|false,        (boolean) If the address is yours or not
        #   "iswatchonly" : true|false,   (boolean) If the address is watchonly
        #   "isscript" : true|false,      (boolean) If the key is a script
        #   "pubkey" : "publickeyhex",    (string) The hex value of the raw public key
        #   "iscompressed" : true|false,  (boolean) If the address is compressed
        #   "account" : "account"         (string) DEPRECATED. The account associated with the address, "" is the default account
        # }
        # 
        # Examples:
        # > bitcoin-cli validateaddress "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "validateaddress", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli validateaddress #{bitcoinaddress}`
      end
      
      def verify_message bitcoinaddress, signature, message
        # Verify a signed message
        # 
        # Arguments:
        # 1. "bitcoinaddress"  (string, required) The bitcoin address to use for the signature.
        # 2. "signature"       (string, required) The signature provided by the signer in base 64 encoding (see signmessage).
        # 3. "message"         (string, required) The message that was signed.
        # 
        # Result:
        # true|false   (boolean) If the signature is verified or not.
        # 
        # Examples:
        # 
        # Unlock the wallet for 30 seconds
        # > bitcoin-cli walletpassphrase "mypassphrase" 30
        # 
        # Create the signature
        # > bitcoin-cli signmessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XZ" "my message"
        # 
        # Verify the signature
        # > bitcoin-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XZ" "signature" "my message"
        # 
        # As json rpc
        # > curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifymessage", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XZ", "signature", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
        `bitcoin-cli verifymessage #{bitcoinaddress} #{signature} #{message}`
      end
    end
  end
end
