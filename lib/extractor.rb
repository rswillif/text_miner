# class for extracting desired information out of text using regular expressions
class Extractor
  def initialize
  end

  def phone_numbers(input)
    input.scan(/\(\d{3}\)\ \d{3}\-\d{4}/)
  end

  def emails(input)
    input.scan(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
  end
end
