$:.unshift File.join(File.dirname(__FILE__))
require 'client/tcp_client.rb'

host = ARGV[0] || 'localhost'
port = ARGV[1] || 3001
bytes = 1024

TCPClient.new(host, port, bytes).send_payload
