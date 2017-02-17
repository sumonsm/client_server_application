require "socket"
host = 'localhost'
port = 20000

server = TCPServer.new(host, port)
puts "Server started.\nListening at port: #{port}"
trap("INT") { puts "Sever stopped."; exit 0}

loop do
  Thread.start(server.accept) do |conn|
    puts "Connection #{conn} accepted."
    
    while line = conn.gets
      puts line.chop
    end

    puts "Connection #{conn} ended."
    conn.close
  end
end