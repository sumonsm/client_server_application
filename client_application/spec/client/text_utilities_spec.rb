require 'spec_helper'
require_relative '../../lib/client/text_utilities'
include TextUtilities

describe "TextUtilities" do
  describe "ascii_to_utf8" do
    let(:ascii) { "this is ascii text".force_encoding("ASCII") }
    subject { ascii_to_utf8(ascii) }
    it "converts ASCII string to UTF-8 encoding" do
      expect( subject ).to be_an_instance_of String
      expect( subject.encoding.to_s ).to eq('UTF-8')
    end
  end

  describe "format_string" do
    let(:unformatted_text) { "this is some random \n\ntext" }
    let(:formatted_text)   { "this*is*some*random***text" }
    subject { format_string(unformatted_text) }
    it "converts unformatted text proper formatting" do
      expect( subject ).to be_an_instance_of String
      expect( subject ).to eq(formatted_text)
    end
  end
end