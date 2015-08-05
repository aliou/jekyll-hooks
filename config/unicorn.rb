@dir = "#{ENV['PWD']}"

working_directory @dir

pid "#{@dir}/pids/unicorn.pid"

# Path to logs
stderr_path "#{@dir}/logs/unicorn.log"
stdout_path "#{@dir}/logs/unicorn.log"

# Unicorn socket
# listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.myapp.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
