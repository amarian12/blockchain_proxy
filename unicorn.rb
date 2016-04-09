working_directory "/root/blockchain_proxy"

pid "/root/blockchain_proxy/pids/unicorn.pid"

stderr_path "/root/blockchain_proxy/logs/unicorn.log"
stdout_path "/root/blockchain_proxy/logs/unicorn.log"

listen "/tmp/unicorn.myapp.sock"

worker_processes 2

timeout 30
