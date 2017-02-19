require 'spec_helper'

describe "TCPClient" do
  before :each do
    @client = TCPClient.new "127.0.0.1", 4001, 64
  end
  
  describe "#new" do
    it "takes three optional parameters and returns a TCPClient object" do
      expect(@client).to be_an_instance_of TCPClient
    end
  end

  describe "#read_payload" do
    subject { @client.instance_eval { read_payload } }
    it "returns a UTF-8 String" do
      expect(subject).to be_an_instance_of String
      expect(subject.encoding.to_s).to eql('UTF-8')
      expect(@client.payload).to be_an_instance_of String
    end
  end
  
  describe "#send_payload" do
    subject { @client.send_payload }
    it "to successfully send payload" do
      socket = double('socket').as_null_object
      TCPSocket.stub(:open).and_return(socket)

      expect(subject).to be(true)
      expect(@client.instance_eval{ payload }).to be_an_instance_of(String)
    end
  end

end