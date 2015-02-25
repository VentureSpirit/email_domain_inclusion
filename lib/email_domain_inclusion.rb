require "email_domain_inclusion/version"

# A custom validator that checks that the email's domain is included in the specified domains
# Usage: validates :email, email_domain: {allowed_domains: ->() { AllowedEmailDomains.pluck(:domain) } }
# +allowed_domains+ can be an array of strings, or a Proc that returns an array of strings
class EmailDomainInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    domains = options[:allowed_domains]
    domains = domains.call if domains.respond_to?(:call)
    domain = domain_from_email(value)
    unless domains.include?(domain)
      record.errors[attribute] << options[:message] || "domain_not_in_list"
    end
  end

  private
  def domain_from_email(email)
    Mail::Address.new(email).try(:domain).try(:downcase)
  rescue Mail::Field::ParseError
    nil
  end
end
