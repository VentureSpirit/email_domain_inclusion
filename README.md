# EmailDomainInclusion

EmailDomainInclusion is a custom ActiveModel::EachValidator that checks if a given email has a whitelisted domain

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'email_domain_inclusion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_domain_inclusion

## Usage

```ruby
class Person
  include ActiveModel::Validations
  attr_accessor :name, :email

  validates :email, email_domain_inclusion: {allow_subdomains: true, allowed_domains: ["hotmail.com", "gmail.com"]}
end
```

You may also pass a Proc to allowed_domains

```ruby
validates :email, email_domain_inclusion: {allowed_domains: ->(person) { AllowedDomains.pluck(:domain) }}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/email_domain_inclusion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
