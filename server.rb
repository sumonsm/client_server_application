$:.unshift File.join(File.dirname(__FILE__))
require 'lib/server/tcp_logger_server.rb'

TCPLoggerServer.new.server_start