module ClientErrors
  # Custom exception for empty payload
  class EmptyPayloadException < StandardError
    def initialize(msg="Error: Payload is empty!")
      super
    end
  end

  # Custom exception for wrong payload encoding
  class PayloadEncodingException < StandardError
    def initialize(msg="Error: Payload is not encoded in UTF-8!")
      super
    end
  end

  # Custom exception for wrong payload formatting
  class PayloadFormattingException < StandardError
    def initialize(msg="Error: Payload is not formatted correctly!")
      super
    end
  end
end
