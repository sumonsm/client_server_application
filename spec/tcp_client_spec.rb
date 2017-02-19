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
    it "successfully sends payload" do
      socket = double('socket').as_null_object
      allow(TCPSocket).to receive(:open).and_return(socket)

      expect(subject).to be(true)
      expect(@client.instance_eval{ payload }).to be_an_instance_of(String)
    end

    it "raises error if it fails to send payload" do
      allow(TCPSocket).to receive(:open).and_return(nil)

      expect(subject).to be(false)
    end

    it "handles connection error" do
      allow(TCPSocket).to receive(:open).and_raise { Errno::ECONNREFUSED.new }

      expect(subject).to be(false)
    end

    it "handles empty payload issue" do
      allow(@client).to receive(:payload).and_return(nil)
      
      expect{ subject }.to output("ERROR: There was a problem with the payload data.\n\tERROR: Payload is empty!\n").to_stdout
      expect(subject).to be(false)
    end

    it "handles payload encoding issues" do
      allow(@client).to receive(:payload).and_return("foo".force_encoding("ISO-8859-15"))
      
      expect{ subject }.to output("ERROR: There was a problem with the payload data.\n\tERROR: Payload is not encoded in UTF-8!\n"
).to_stdout
      expect(subject).to be(false)
    end

    it "handles payload formatting issues" do
      allow(@client).to receive(:payload).and_return("erewrwr werwerrw\nwrewrr\n".force_encoding("UTF-8"))
      
      expect{ subject }.to output("ERROR: There was a problem with the payload data.\n\tERROR: Payload is not formatted correctly!\n").to_stdout
      expect(subject).to be(false)
    end
  end
end