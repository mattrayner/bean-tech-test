# Bean Tech Test

## Thoughts
I initially considered creating a tree based solution after mm conversation with Jamie
but due to a lack of time abandoned this for regex. In order to improve accuracy I 
added a concept of 'child' merchants - so when a set of Regexes 'collide' you can 
create an order of importance i.e. 'amazon' > 'amazon prime', 'uber' > 'uber eats' etc.

### Logistics
Through my use of 'child' merchants, and a fully database driven approach you could
ease logistical burdens by creating an admin CRUD interface to manage matchers and 
merchants. Although there will be a teething period whilst the major transaction 
types are matched you could take a Monzo/Startling approach to crowd sourcing missed 
transactions. Offering users of the Bean app the ability to 'suggest' a merchant.

I note the very possible collisions with any approach, I have tried to limit the
impact of collisions by attempting to match all the children of any major collision, 
but have not made this approach recursive for the sake of time. I.e. if you have 
'Amazon' > 'Amazon Prime' > 'Amazon Prime Now' only 'Amazon' and 'Amazon Prime' would
be checked.

## Usage
I've set the application up to use ActiveRecord, with the seeds file providing all the
database bootstrapping, modifying entries within `db/seeds.rb` will allow you to add/modify
merchants and matchers.

For ease of testing I've added a CSV file in `spec/fixtures/transactions.csv` which contains
the descriptions and expected merchants to be matched based on your PDF. Adding/removing 
lines will dynamically create/remove tests from the `spec/claddifier_spec.rb` file. Modifying 
this should allow you to test my implementation with RSpec.

For additional command line use i've written a simple helper, `app/main.rb` which will take a 
CSV path as an argument. It will then read the CSV and run the first column through my 
classification system. If you provide no value, the `spec/fixtures/transactions.csv` file will
be used. I've also included a transactions.csv file in the root which contains some edge case
descriptions from above.

### Quick start
```bash
bundle install
bundle exec rake db:create db:migrate db:seed
bundle exec rake db:test:prepare
bundle exec rspec

bundle exec ruby app/main.rb transactions.csv
bundle exec ruby app/main.rb
```

### CSV example
If you want to create a CSV for usage through main.rb or within rspec you should use the format
below, column 0 is description and column 1 is expected merchant name.

```csv
sainsbury's sprmrkts lt london,Sainsburys
```

## Notes
I viewed the file `/app/main.rb` to be incidental to the test and my approach, and as such have 
left it untested on purpose. In a production environment this would not be the case.