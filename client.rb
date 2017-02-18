$:.unshift File.join(File.dirname(__FILE__))
require 'lib/client/tcp_client.rb'

TCPClient.new.send_payload
