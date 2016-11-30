class Separator
  def initialize
  end

  def words(input)
    input_array = input.split(' ')
    return nil if input_array.length == 1 && input_array[0].to_i.to_s == input_array[0]
    input_array.each { |i| i.to_i.to_s == i ? input_array.delete(i) : i }
    input_array
  end

  def phone_number(input)
    input_array = input.split(/[\s,-]+/)
    return nil if input_array.length < 3
    area_code = input_array[0].gsub!(/[^0-9]/, '')
    input_array.delete_at(0)
    rest_of_number = input_array.join('-')
    return {area_code: area_code, number: rest_of_number}
  end

  def money
  end

  def zipcode
  end

  def date
  end

  def address
  end
end
