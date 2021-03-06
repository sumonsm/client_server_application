require 'client/client_errors.rb'
require 'client/text_utilities.rb'

class TCPClient
  # include custom exceptions
  include ClientErrors
  include TextUtilities
    
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
      return false if socket.nil?
      
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
end
