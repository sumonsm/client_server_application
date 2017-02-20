module TextUtilities
  # Encode ASCII string to UTF-8
  # Return: UTF-8 string
  def ascii_to_utf8(ascii_str=nil)
    return nil unless ascii_str
    return utf8_str = ascii_str.encode("UTF-8", invalid: :replace, undef: :replace)
  end

  # Format string in desired pattern
  # Return: Formatted string
  def format_string(str=nil)
    return nil unless str
    return str.gsub(/\s/, "*")
  end
end
