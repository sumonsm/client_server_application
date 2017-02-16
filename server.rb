require "socket"
server = TCPServer.new('localhost', port = 20000)
puts "Server started.\nListening at port #{port} ..."
loop do
  Thread.start(server.accept) do |conn|
    puts "Connection #{conn} accepted."
    
    while line = conn.gets   # Read lines from the socket
      puts line.chop      # And print with platform line terminator
    end

    puts "Connection #{conn} ended."
    conn.close
  end
end
puts "Server stopped"