require 'validator'

describe Validator do
  before do
    @v = Validator.new
  end

  describe '#binary' do
    it 'returns true or false if a string is a binary number' do
      expect(@v.binary('0')).to eq true
      expect(@v.binary('1')).to eq true
      expect(@v.binary('01')).to eq true
      expect(@v.binary('10')).to eq true
      expect(@v.binary('1110100010')).to eq true
      expect(@v.binary('')).to eq false
      expect(@v.binary('911')).to eq false
    end
  end

  describe '#binary_even' do
    it 'returns true if a string is an even binary number' do
      expect(@v.binary_even('10')).to eq true
      expect(@v.binary_even('1110100010')).to eq true
      expect(@v.binary_even('1011')).to eq false
    end
  end

  describe '#hex' do
    it 'returns true if a string is a hex value' do
      expect(@v.hex('CAFE')).to eq true
      expect(@v.hex('9F9')).to eq true
      expect(@v.hex('123')).to eq true
      expect(@v.hex('6720EB3A9D1')).to eq true
      expect(@v.hex('')).to eq false
      expect(@v.hex('COFFEE')).to eq false
    end
  end

  describe '#word' do
    it 'returns true if the string is a word' do
      expect(@v.word('hello')).to eq true
      expect(@v.word('wonderful')).to eq true
      expect(@v.word('zyggon')).to eq true
      expect(@v.word('horse-dagger')).to eq true
      expect(@v.word('18-wheeler')).to eq true
      expect(@v.word('')).to eq false
      expect(@v.word('12')).to eq false
      expect(@v.word('!!!')).to eq false
      expect(@v.word('bar*us')).to eq false
    end
  end

  describe '#words' do
    it 'returns true if the string is all words' do
      # and if the optional count parameter matches the number of words
      expect(@v.words('hello')).to eq true
      expect(@v.words('hello world')).to eq true
      expect(@v.words('raggggg hammer dog')).to eq true
      expect(@v.words('18-wheeler tarbox')).to eq true
      expect(@v.words('hello', count: 1)).to eq true
      expect(@v.words('hello world', count: 2)).to eq true
      expect(@v.words('raggggg hammer dog', count: 3)).to eq true
      expect(@v.words('18-wheeler tarbox', count: 2)).to eq true
      expect(@v.words('')).to eq false
      expect(@v.words('12')).to eq false
      expect(@v.words('hey !!!', count: 2)).to eq false
      expect(@v.words('bar*us w!zard', count: 2)).to eq false
      expect(@v.words('hello', count: 2)).to eq false
      expect(@v.words('hello world', count: 3)).to eq false
      expect(@v.words('raggggg hammer dog', count: 1)).to eq false
      expect(@v.words('18-wheeler tarbox', count: 3)).to eq false
    end
  end

  describe '#phone_number' do
    it 'returns true for valid US phone number formats' do
      expect(@v.phone_number('919-555-1212')).to eq true
      expect(@v.phone_number('(919) 555-1212')).to eq true
      expect(@v.phone_number('9195551212')).to eq true
      expect(@v.phone_number('919.555.1212')).to eq true
      expect(@v.phone_number('919 555-1212')).to eq true
      expect(@v.phone_number('')).to eq false
      expect(@v.phone_number('555-121')).to eq false
      expect(@v.phone_number('1212')).to eq false
      expect(@v.phone_number('mobile')).to eq false
    end
  end

  describe '#money' do
    it 'returns true for valid US money formats' do
      expect(@v.money('$4')).to eq true
      expect(@v.money('$19')).to eq true
      expect(@v.money('$19.00')).to eq true
      expect(@v.money('$3.58')).to eq true
      expect(@v.money('$1000')).to eq true
      expect(@v.money('$1000.00')).to eq true
      expect(@v.money('$1,000')).to eq true
      expect(@v.money('$1,000.00')).to eq true
      expect(@v.money('$5,555,555')).to eq true
      expect(@v.money('$5,555,555.55')).to eq true
      expect(@v.money('$45,555,555.55')).to eq true
      expect(@v.money('$456,555,555.55')).to eq true
      expect(@v.money('$1234567.89')).to eq true
      expect(@v.money('')).to eq false
      expect(@v.money('$12,34')).to eq false
      expect(@v.money('$1234.9')).to eq false
      expect(@v.money('$1234.999')).to eq false
      expect(@v.money('$')).to eq false
      expect(@v.money('31')).to eq false
      expect(@v.money('$$31')).to eq false
    end
  end

  describe '#zip_code' do
    it 'returns true for valid zip code formats' do
      expect(@v.zipcode('63936')).to eq true
      expect(@v.zipcode('50583')).to eq true
      expect(@v.zipcode('48418')).to eq true
      expect(@v.zipcode('06399')).to eq true
      expect(@v.zipcode('26433-3235')).to eq true
      expect(@v.zipcode('64100-6308')).to eq true
      expect(@v.zipcode('')).to eq false
      expect(@v.zipcode('7952')).to eq false
      expect(@v.zipcode('115761')).to eq false
      expect(@v.zipcode('60377-331')).to eq false
      expect(@v.zipcode('8029-3924')).to eq false
    end
  end

  describe '#date' do
    it 'returns true for valid date format' do
      expect(@v.date('9/4/1976')).to eq true
      expect(@v.date('1976-09-04')).to eq true
      expect(@v.date('2015-01-01')).to eq true
      expect(@v.date('02/15/2004')).to eq true
      expect(@v.date('9/4')).to eq false
      expect(@v.date('2015')).to eq false
    end
  end

  # ADVANCED MODE BEGINS

  describe '#date' do
    it 'returns true for valid date format - advanced' do
      expect(@v.date('2014 Jan 01')).to eq true
      expect(@v.date('2014 January 01')).to eq true
      expect(@v.date('Jan. 1, 2015')).to eq true
      expect(@v.date('07/40/2015')).to eq false
      expect(@v.date('02/30/2015')).to eq false
    end
  end

  describe '#email' do
    it 'returns true for valid email formats' do
      expect(@v.email('stroman.azariah@yahoo.com')).to eq true
      expect(@v.email('viola91@gmail.com')).to eq true
      expect(@v.email('eathel.west@example.org')).to eq true
      expect(@v.email('dwehner@harley.us')).to eq true
      expect(@v.email('malcolm.haley@hotmail.com')).to eq true
      expect(@v.email('ezzard90@hotmail.com')).to eq true
      expect(@v.email('legros.curley@gmail.com')).to eq true
      expect(@v.email('leatha75@mertz.net')).to eq true
      expect(@v.email('bonita43@yahoo.com')).to eq true
      expect(@v.email('')).to eq false
      expect(@v.email('legros.curley')).to eq false
      expect(@v.email('mertz.net')).to eq false
      expect(@v.email('bonita43@')).to eq false
    end
  end

  describe '#address' do
    it 'returns true for valid US address formats' do
      expect(@v.address('368 Agness Harbor Port Mariah, MS 63293')).to eq true
      expect(@v.address('96762 Juluis Road Suite 392 ' \
                        'Lake Imogenemouth, AK 20211')).to eq true
      expect(@v.address('671 Tawnya Island Apt. 526 ' \
                        'Clementeburgh, AK 82652')).to eq true
      expect(@v.address('568 Eunice Shoals ' \
                        'Parishaven, AK 09922-2288')).to eq true
      expect(@v.address('8264 Schamberger Spring, ' \
                        'Jordanside, MT 98833-0997')).to eq true
      expect(@v.address('')).to eq false
      expect(@v.address('99132 Kaylah Union Suite 301')).to eq false
      expect(@v.address('Lake Joellville, NH')).to eq false
      expect(@v.address('35981')).to eq false
    end
  end
end
