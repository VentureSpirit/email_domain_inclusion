require "email_domain_inclusion/version"

# A custom validator that checks that the email's domain is included in the specified domains
# Usage: validates :email, email_domain: {allowed_domains: ->() { AllowedEmailDomains.pluck(:domain) } }
# +allowed_domains+ can be an array of strings, or a Proc that returns an array of strings
class EmailDomainInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    allow_subdomains = options[:allow_subdomains]
    unless valid_full_domain?(value) || (allow_subdomains && valid_subdomain?(value))
      record.errors[attribute] << options[:message] || "domain_not_in_list"
    end
  end

  private
  def valid_subdomain?(value)
    domain = domain_from_email(value)
    return false unless domain
    allowed_domains.any? { |allowed_domain| domain.end_with? ".#{allowed_domain}" }
  end

  def valid_full_domain?(value)
    domain = domain_from_email(value)
    return false unless domain
    allowed_domains.include?(domain)
  end

  def allowed_domains
    domains = options[:allowed_domains]
    domains = domains.call if domains.respond_to?(:call)
    domains
  end

  def domain_from_email(email)
    Mail::Address.new(email).try(:domain).try(:downcase)
  rescue Mail::Field::ParseError
    nil
  end
end
