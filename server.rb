class Server
  def initialize(hostname=nil, port=nil, log_file_name=nil)
    @host = hostname || 'localhost'
    @port = port || 20000
    file_name = log_file_name || 'server.log'
    @log_file_path = File.join('server_log', file_name)
  end

  def server_start
    require "socket"
    server = TCPServer.new(@host, @port)
    puts "Server started.\nListening at port: #{@port}"
    trap("INT") { puts "\nInterrupt signal recieved.\nStopping server."; exit 0}

    loop do
      Thread.new(server.accept) do |conn|
        puts "Connection #{conn} accepted."
        
        write_to_log(Time.now.to_s + ' ')
        while line = conn.gets
          puts line.chop
          write_to_log(line)
        end

        puts "Connection #{conn} ended."
        conn.close
      end
    end
  end

  private

  def write_to_log(text)
    File.open(@log_file_path, 'a') do |file|
      # threadsafe write
      file.flock(File::LOCK_EX)
      file << text
      file.flush
      file.flock(File::LOCK_UN)
    end
  end
end

Server.new.server_start