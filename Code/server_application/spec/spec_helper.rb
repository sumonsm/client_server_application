require 'simplecov'
SimpleCov.start do
  # define report groups
  add_group "Server", "lib/server"
  # define where the specs are
  add_filter "/spec/"
end

require_relative '../lib/server/tcp_logger_server'
