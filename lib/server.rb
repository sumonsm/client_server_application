$:.unshift File.join(File.dirname(__FILE__))
require 'server/tcp_logger_server.rb'

TCPLoggerServer.new.server_start