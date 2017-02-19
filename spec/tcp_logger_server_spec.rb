require 'spec_helper'

describe "TCPLoggerServer" do
  before :each do
    @server = TCPLoggerServer.new "127.0.0.1", 4001, "test.log"
  end
  
  # describe "#new" do
  #   it "takes three optional parameters and returns a TCPLoggerServer object" do
  #     expect(@server).to be_an_instance_of TCPLoggerServer
  #   end
  # end

  # describe "#write_to_log" do
  #   subject { @string_to_log = "test string" }
  #   it "writes text to logfile" do
  #     @server.write_to_log(subject)
  #     filename = File.join( @server.instance_eval { @log_file_path } )
  #     logged_content = File.read(filename)
      
  #     expect(/#{subject}/).to match(logged_content)
  #   end
  # end

  # describe "#server_stop" do
  #   subject { @server.server_stop }
  #   it "informs about server shutdown" do
  #     expect(subject).to output("\n").to_stdout
  #   end
  # end

  describe "#server_start" do
    subject do
      server = double('server').as_null_object
      allow(TCPServer).to receive(:open).and_return(server)
      pid = Process.fork do
        @server.server_start
      end
      sleep 1

      require 'socket'
      socket = TCPSocket.open("127.0.0.1", 4001)
      socket.puts "testing"
      sleep 1
      Process.kill 'INT', pid
    end
    it "Accepts TCP connection" do
      expect{ subject }.to output("sdff").to_stderr      
    end
  end
end