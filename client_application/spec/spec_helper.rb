require 'simplecov'
SimpleCov.start do
  # define report groups
  add_group "Client", "lib/client"
  # define where the specs are
  add_filter "/spec/"
end

require_relative '../lib/client/tcp_client'
