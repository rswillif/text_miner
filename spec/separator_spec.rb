require 'separator'

describe Separator do
  before do
    @s = Separator.new
  end

  describe '#words' do
    it 'returns an Array of words' do
      expect(@s.words('hello')).to eq ['hello']
      expect(@s.words('hello world')).to eq ['hello', 'world']
      expect(@s.words('raggggg hammer dog')).to eq ['raggggg', 'hammer', 'dog']
      expect(@s.words('18-wheeler tarbox')).to eq ['18-wheeler', 'tarbox']
      expect(@s.words('12')).to eq nil
    end
  end

  describe '#phone_number' do
    it 'returns a hash with phone number and area code' do
      expect(@s.phone_number('919-555-1212')).to eq({'area_code': '919', 'number': '555-1212'})
      expect(@s.phone_number('(919) 555-1212')).to eq({'area_code': '919', 'number': '555-1212'})
      expect(@s.phone_number('9195551212')).to eq({'area_code': '919', 'number': '555-1212'})
      expect(@s.phone_number('919.555.1212')).to eq({'area_code': '919', 'number': '555-1212'})
      expect(@s.phone_number('919 555-1212')).to eq({'area_code': '919', 'number': '555-1212'})
      expect(@s.phone_number('555-121')).to eq nil
    end
  end

  describe '#money' do
    it 'returns a hash with currency symbol and amount' do
      expect(@s.money('$4')).to eq({'currency': '$', 'amount': 4.0})
      expect(@s.money('$19')).to eq({'currency': '$', 'amount': 19.0})
      expect(@s.money('$19.00')).to eq({'currency': '$', 'amount': 19.0})
      expect(@s.money('$3.58')).to eq({'currency': '$', 'amount': 3.58})
      expect(@s.money('$1000')).to eq({'currency': '$', 'amount': 1000.0})
      expect(@s.money('$1000.00')).to eq({'currency': '$', 'amount': 1000.0})
      expect(@s.money('$1,000')).to eq({'currency': '$', 'amount': 1000.0})
      expect(@s.money('$1,000.00')).to eq({'currency': '$', 'amount': 1000.0})
      expect(@s.money('$5,555,555')).to eq({'currency': '$', 'amount': 5555555.0})
      expect(@s.money('$5,555,555.55')).to eq({'currency': '$', 'amount': 5555555.55})
      expect(@s.money('$45,555,555.55')).to eq({'currency': '$', 'amount': 45555555.55})
      expect(@s.money('$456,555,555.55')).to eq({'currency': '$', 'amount': 456555555.55})
      expect(@s.money('$1234567.89')).to eq({'currency': '$', 'amount': 1234567.89})
      expect(@s.money('$12,34')).to eq nil
      expect(@s.money('$1234.9')).to eq nil
      expect(@s.money('$1234.999')).to eq nil
      expect(@s.money('$')).to eq nil
      expect(@s.money('31')).to eq nil
      expect(@s.money('$$31')).to eq nil
    end
  end

  describe '#zipcode' do
    it 'returns a hash with five digit zip code and plus four if exists' do
      expect(@s.zipcode('63936')).to eq({'zip': '63936', 'plus4': nil})
      expect(@s.zipcode('50583')).to eq({'zip': '50583', 'plus4': nil})
      expect(@s.zipcode('06399')).to eq({'zip': '06399', 'plus4': nil})
      expect(@s.zipcode('26433-3235')).to eq({'zip': '26433', 'plus4': '3235'})
      expect(@s.zipcode('64100-6308')).to eq({'zip': '64100', 'plus4': '6308'})
      expect(@s.zipcode('7952')).to eq nil
      expect(@s.zipcode('115761')).to eq nil
      expect(@s.zipcode('60377-331')).to eq nil
      expect(@s.zipcode('8029-3924')).to eq nil
    end
  end

  describe '#date' do
    it 'returns a hash of day, month, and year' do
      expect(@s.date('9/4/1976')).to eq({'month': 9, 'day': 4, 'year': 1976})
      expect(@s.date('1976-09-04')).to eq({'month': 9, 'day': 4, 'year': 1976})
      expect(@s.date('2015-01-01')).to eq({'month': 1, 'day': 1, 'year': 2015})
      expect(@s.date('02/15/2004')).to eq({'month': 2, 'day': 15, 'year': 2004})
      expect(@s.date('9/4')).to eq nil
      expect(@s.date('2015')).to eq nil
    end
  end

  # ADVANCED MODE BEGINS

  describe '#date' do
    it 'returns a hash of day, month, year - advanced' do
      expect(@s.date('2014 Jan 01')).to eq({'month': 1, 'day': 1, 'year': 2014})
      expect(@s.date('2014 January 01')).to eq({'month': 1, 'day': 1, 'year': 2014})
      expect(@s.date('Jan. 1, 2015')).to eq({'month': 1, 'day': 1, 'year': 2015})
      expect(@s.date('07/40/2015')).to eq nil
      expect(@s.date('02/30/2015')).to eq nil
    end
  end

  describe '#email' do
    it 'returns the parts of an email address' do
      expect(@s.email('stroman.azariah@yahoo.com')).to eq({
        'local': 'stroman.azariah',
        'domain': 'yahoo.com'
      })
      expect(@s.email('viola91@gmail.com')).to eq({
        'local': 'viola91',
        'domain': 'gmail.com'
      })
      expect(@s.email('legros.curley')).to eq nil
    end
  end

  describe '#address' do
    it 'returns a hash of address info' do
      expect(@s.address('368 Agness Harbor Port Mariah, MS 63293')).to eq({
        'address': '368 Agness Harbor',
        'city': 'Port Mariah',
        'state': 'MS',
        'zip': '63293',
        'plus4': None
      })
      expect(@s.address('8264 Schamberger Spring, Jordanside, MT 98833-0997')).to eq({
        'address': '8264 Schamberger Spring',
        'city': 'Jordanside',
        'state': 'MT',
        'zip': '98833', 'plus4': '0997'
      })
      expect(@s.address('Lake Joellville, NH')).to eq nil
    end
  end
end
