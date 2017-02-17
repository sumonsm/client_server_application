require "socket"
server = TCPServer.new('localhost', port = 20000)
puts "Server started.\nListening at port #{port} ..."

loop do
  Thread.start(server.accept) do |conn|
    puts "Connection #{client = conn.gethostname} accepted."
    
    while line = conn.gets
      puts line.chop
    end

    puts "Connection #{client} ended."
    conn.close
  end
end
puts "Server stopped"