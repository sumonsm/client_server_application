$:.unshift File.join(File.dirname(__FILE__))
require 'client/tcp_client.rb'

TCPClient.new.send_payload
