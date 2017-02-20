require 'spec_helper'
require_relative '../../lib/client/client_errors'
include ClientErrors

describe "ClientErrors" do
  describe "EmptyPayloadException" do
    it "raises EmptyPayloadException with given message" do
      expect { raise EmptyPayloadException, "my message" }.
      to raise_error(EmptyPayloadException, /my mess/)
    end
  end
  describe "PayloadEncodingException" do
    it "raises PayloadEncodingException with given message" do
      expect { raise PayloadEncodingException, "my message" }.
      to raise_error(PayloadEncodingException, /my mess/)
    end
  end
  describe "PayloadFormattingException" do
    it "raises PayloadFormattingException with given message" do
      expect { raise PayloadFormattingException, "my message" }.
      to raise_error(PayloadFormattingException, /my mess/)
    end
  end
end