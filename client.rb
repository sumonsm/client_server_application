$:.unshift File.join(File.dirname(__FILE__))
require 'lib/tcp_client.rb'

TCPClient.new.send_payload
