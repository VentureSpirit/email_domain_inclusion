require "email_domain_inclusion/version"

# A custom validator that checks that the email's domain is included in the specified domains
# Usage: validates :email, email_domain: {allowed_domains: ->() { AllowedEmailDomains.pluck(:domain) } }
# +allowed_domains+ can be an array of strings, or a Proc that returns an array of strings
class EmailDomainInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    domains = options[:allowed_domains]
    domain = Mail::Address.new(value).try(:domain).try(:downcase)
    domains = domains.call if domains.respond_to?(:call)
    unless domains.include?(domain)
      record.errors[attribute] << options[:message] || "domain_not_in_list"
    end
  end
end
