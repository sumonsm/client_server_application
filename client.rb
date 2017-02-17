class Client

  def initialize(hostname=nil, port=nil, bytes=nil)
    @hostname = hostname || 'localhost'
    @port = port || 20000
    @bytes_to_read = bytes || 1024
  end
  
  def send_payload
    begin
      payload = validate(read_payload)

      require 'socket'
      socket = TCPSocket.open(@hostname, @port)
      puts "Sending payload:\n#{payload}\n" ### =========
      socket.puts payload
      socket.close
    rescue EmptyPayloadException, PayloadEncodingException, PayloadFormattingException => exception
      puts "There was a problem with the payload data.\n\t#{exception.message}"
    rescue Errno::ECONNREFUSED => exception
      puts "Could not connect to server.\n\t#{exception.message}"
    rescue => exception
      puts exception.message
    end
  end

  private

  def read_payload
    ascii_str = File.read("/dev/urandom", @bytes_to_read)
    utf8_str =  ascii_to_utf8(ascii_str)
    formatted_str = utf8_str ? utf8_str.gsub(/\s/, "*") : nil
  end

  def validate(payload)
    raise EmptyPayloadException.new unless payload
    raise PayloadEncodingException.new unless payload.encoding.to_s == "UTF-8"
    raise PayloadFormattingException.new if payload =~ / /
    return payload
  end

  def ascii_to_utf8(ascii_str=nil)
    return nil unless ascii_str
    return utf8_str = ascii_str.encode("UTF-8", invalid: :replace, undef: :replace)
  end
end

class EmptyPayloadException < StandardError
  def initialize(msg="Error: Payload is empty!")
    super
  end
end

class PayloadEncodingException < StandardError
  def initialize(msg="Error: Payload is not encoded in UTF-8!")
    super
  end
end


class PayloadFormattingException < StandardError
  def initialize(msg="Error: Payload is not formatted correctly!")
    super
  end
end

Client.new.send_payload
