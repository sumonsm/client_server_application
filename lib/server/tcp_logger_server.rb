class TCPLoggerServer
  def initialize(hostname=nil, port=nil, log_file_name=nil)
    @host = hostname || 'localhost'
    @port = port || 20000
    file_name = log_file_name || 'server.log'
    @log_file_path = File.join('server_log', file_name)
    Thread.abort_on_exception = true
  end

  def server_start
    begin
      require "socket"
      server = TCPServer.new(@host, @port)
      puts "Server started.\nListening at port: #{@port}"
      trap("INT") { stopping() }

      # Main sever loop
      loop do
        # spawn a thread and accept connection
        Thread.new(server.accept) do |conn|
          puts "Connection #{conn} accepted."
          
          write_to_log("[#{Time.now.to_s}] ")
          while line = conn.gets
            #raise "Empty string recieved" if line.chop == ""

            puts "Recieved: #{line.chop}\n"
            write_to_log(line.chop)
          end
        end
      end
    rescue => exception
      puts "ERROR: #{exception.inspect}"
    end
  end

  # just be informative
  def stopping
    puts "\nInterrupt signal recieved.\nStopping server."
    exit 0
  end
  
  # stop server on ctrl+c
  def server_stop
    Process.kill 'INT', 0
  end
  
  # Append text to the log file
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
