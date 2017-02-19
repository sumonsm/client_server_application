require 'client/client_errors.rb'

class TCPClient
  # include custom exceptions
  include ClientErrors
    
  # Initialize variables
  def initialize(hostname=nil, port=nil, bytes=nil)
    @hostname = hostname || 'localhost'
    @port = port || 20000
    @bytes_to_read = bytes || 1024
    @payload = nil
  end
  
  # Expose the payload
  # Return: Payload string
  def payload
    @payload
  end
  
  # Get payload data, validate, connect to server using TCP socket and send payload
  # Return: true/false based on success or failure
  def send_payload
    begin
      read_payload
      validate_payload

      puts "Establishing connecting with server at:\n\t#{@hostname}:#{@port}"
      require 'socket'
      socket = TCPSocket.open(@hostname, @port)
      
      puts "Sending payload:\n#{payload}\n"
      socket.puts payload
      puts "Payload sent."
      
      socket.close
      puts "Connection closed."
      puts "All done, exiting."
      return true
    rescue EmptyPayloadException,
           PayloadEncodingException,
           PayloadFormattingException => exception
      puts "ERROR: There was a problem with the payload data.\n\t#{exception.message}"
      return false
    rescue => exception
      puts "ERROR: #{exception.message}"
      puts "BACKTRACE: #{exception.backtrace.join}"
      return false
    end
  end

  private

  # Read data, encode and format.
  # Return: Formatted UTF-8 string
  def read_payload
    ascii_str     = File.read("/dev/urandom", @bytes_to_read)
    utf8_str      = ascii_to_utf8(ascii_str)
    formatted_str = format_string(utf8_str)
    @payload      = formatted_str
  end
  
  # Validates that payload is correct
  # Return: Payload string
  def validate_payload
    raise EmptyPayloadException.new unless payload
    raise PayloadEncodingException.new unless payload.encoding.to_s == "UTF-8"
    raise PayloadFormattingException.new if payload =~ / /
  end
  
  # Encode ASCII string to UTF-8
  # Return: UTF-8 string
  def ascii_to_utf8(ascii_str=nil)
    return nil unless ascii_str
    return utf8_str = ascii_str.encode("UTF-8", invalid: :replace, undef: :replace)
  end

  # Format string in desired pattern
  # Return: Formatted string
  def format_string(str=nil)
    return nil unless str
    return str.gsub(/\s/, "*")
  end
end
