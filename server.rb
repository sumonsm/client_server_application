require "socket"  
server = TCPServer.new('localhost', port = 20000)
puts "Server started.\nListening port #{port} ..."
loop do  
  Thread.start(server.accept) do |s|  
    print(s, " is accepted\n")  
    
    while line = s.gets   # Read lines from the socket
      puts line.chop      # And print with platform line terminator
    end

    print(s, " is gone\n")  
    s.close  
  end
end  
puts "Server stopped"