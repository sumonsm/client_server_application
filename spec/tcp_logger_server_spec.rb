require 'spec_helper'

describe "TCPLoggerServer Live Mode" do
  before :each do
    @server = TCPLoggerServer.new "127.0.0.1", 4001, "test.log"
    Thread.new do
      @server.server_start
    end
    sleep 1
  end

  after :each do
    @server_stop
  end

  describe "#server_start" do
    subject do
      socket = TCPSocket.open("127.0.0.1", 4001)
      socket.puts "testing"
      sleep 1
    end
    it "Sever accepts TCP connection and recieves data" do
      expect{ subject }.to output(/Connection #<TCPSocket:.*> accepted.\nRecieved: testing\n/).to_stdout
    end
  end
end

describe "TCPLoggerServer" do
  before :each do
    @server = TCPLoggerServer.new "127.0.0.1", 4001, "test.log"
  end

  describe "#new" do
    it "takes three optional parameters and returns a TCPLoggerServer object" do
      expect(@server).to be_an_instance_of TCPLoggerServer
    end
  end

  describe "#write_to_log" do
    subject { @string_to_log = "test string" }
    it "writes text to logfile" do
      @server.write_to_log(subject)
      filename = File.join( @server.instance_eval { @log_file_path } )
      logged_content = File.read(filename)
      
      expect(/#{subject}/).to match(logged_content)
    end
  end

  describe "#stopping" do
    subject { @server.stopping }
    it "informs about server shutdown" do
      expect{subject}.to output("\nInterrupt signal recieved.\nStopping server.\n").to_stdout
    end
  end
end