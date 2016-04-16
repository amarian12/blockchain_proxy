working_directory "/home/big_earth_blockchain/blockchain_proxy"

pid "/home/big_earth_blockchain/blockchain_proxy/pids/unicorn.pid"

stderr_path "/home/big_earth_blockchain/blockchain_proxy/logs/unicorn.log"
stdout_path "/home/big_earth_blockchain/blockchain_proxy/logs/unicorn.log"

listen "/tmp/unicorn.blockchain_proxy.sock"

worker_processes 2

timeout 30
