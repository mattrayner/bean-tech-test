def create_merchant(name, *regex)
  matchers = regex.map do |regex_value|
    matcher = Matcher.new
    matcher.regex = regex_value
  end

  merchant = Merchant.new
  merchant.name = name
  merchant.matchers = matchers

  merchant.save

  merchant
end

create_merchant('Sainsburys', '\\sainsbury\'s\\')

uber_merchant = create_merchant('Uber', '\\uber\\')
uber_eats_merchant = create_merchant('Uber Eats', '\\uber eats\\')
uber_merchant.children << uber_eats_merchant

create_merchant('Netflix', '\\netflix\\')

amazon_merchant = create_merchant('Amazon', '\\amazon\\')
prime_merchant = create_merchant('Amazon Prime', '\\amazon prime\\')
amazon_merchant.children << prime_merchant

create_merchant('Google', '\\google\\')

create_merchant('DVLA', '\\dvla\\')

sky_merchant = create_merchant('Sky', '\\sky\\')
sky_digital_merchant = create_merchant('Sky Digital', '\\sky digital\\')
sky_merchant.children = sky_digital_merchant
