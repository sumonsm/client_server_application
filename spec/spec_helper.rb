require 'simplecov'
SimpleCov.start do
  add_group "Client", "lib/client"
  add_group "Server", "lib/server"
  add_filter "/spec/"
end

require_relative '../lib/client/tcp_client'
require_relative '../lib/client/client_errors'
require_relative '../lib/server/tcp_logger_server'
