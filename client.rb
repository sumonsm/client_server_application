
def get_payload_data
  ascii_str = File.read("/dev/urandom", 1024)
  utf8_str  = ascii_str.encode("UTF-8", invalid: :replace, undef: :replace)
  formatted_str = utf8_str.gsub(/\s/, "*")
end

puts payload = get_payload_data


# ====================================
require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 20000

s = TCPSocket.open(hostname, port)

s.puts payload
  
s.close               # Close the socket when done