require 'spec_helper'

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

  describe "#server_stop" do
    subject { @server.server_stop }
    it "informs about server shutdown" do
      expect{ subject }.to output("ERROR: There was a problem with the payload data.\n\tERROR: Payload is empty!\n").to_stdout
    end
  end

  describe "#server_start" do
    subject { @server.server_start }
    it "erwr" do
      server = double('server').as_null_object
      allow(TCPserver).to receive(:open).and_return(server)

      expect(subject).to be(true)
    end
  end
end