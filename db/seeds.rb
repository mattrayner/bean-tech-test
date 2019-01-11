Dir[File.join(__dir__, '..', 'app', 'models', '*.rb')].each { |file| require file }

def create_merchant(name, parent, *regex)
  matchers = regex.map do |regex_value|
    matcher = Matcher.new
    matcher.regex = regex_value

    matcher
  end

  merchant = Merchant.new
  merchant.name = name
  merchant.parent = parent
  merchant.matchers = matchers

  merchant.save

  merchant
end

create_merchant('Sainsburys', nil, 'sainsbury\'s')

uber_merchant = create_merchant('Uber', nil, 'uber')
create_merchant('Uber Eats', uber_merchant,'uber eats')

create_merchant('Netflix', nil,'netflix')

amazon_merchant = create_merchant('Amazon', nil, 'amazon')
create_merchant('Amazon Prime', amazon_merchant, 'amazon prime')

create_merchant('Google', nil, 'google')

create_merchant('DVLA', nil, 'dvla')

sky_merchant = create_merchant('Sky', nil, 'sky')
create_merchant('Sky Digital', sky_merchant, 'sky digital')
