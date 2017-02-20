$:.unshift File.join(File.dirname(__FILE__))
require 'server/tcp_logger_server.rb'

host = ARGV[0] || 'localhost'
port = ARGV[1] || 3001
logfile = ARGV[2] || "tcp.log"

TCPLoggerServer.new(host, port, logfile).server_start