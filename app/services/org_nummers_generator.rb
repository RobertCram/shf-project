# Generate a valid Swedish OrganisationNummer (OrgNummer; OrgNr).
#
# It must be 10 digits and the last digit must be the valid Luhn checksum, per
# https://sv.wikipedia.org/wiki/Organisationsnummer
#

require 'orgnummer'
require 'set'

class OrgNummersGenerator

  MAX_NUM = 9999999999 unless defined?(MAX_NUM)
  MIN_NUM = 1000000000 unless defined?(MIN_NUM)  # orgnummer gem will not recognize any number less than this as valid

  NONE_FOUND = nil  unless defined?(NONE_FOUND)


  def self.generate(number_to_generate = 1)

    results = Set.new

    num_tries = 0
    max_tries = MAX_NUM - MIN_NUM

    # num_tries keeps use from trying forever.
    # The maxium number of times we try to get a valid org_number is max_tries.
    # It is a somewhat arbitrary limit on how many times we can try.
    # Even though each try is a Random number, so it is possible to get the same number more than once,
    # this is a reasonable (if clunky) limit.
    while results.count < number_to_generate && (num_tries < max_tries) do
      number_to_generate.times do
        org_num = generate_one
        num_tries += 1 if results.add?(org_num)
      end

    end

    results
  end


  def self.generate_one

    current_try = Random.rand(MIN_NUM..MAX_NUM)

    # just brute force keep trying until we blindly find one that validates
    # Note that Orgnummer.new(9999999999).valid? == true So if we hit our max, we're OK because we've found one that validates with the checksum
    current_try += 1 until Orgnummer.new(current_try).valid?

    "%010d" % "#{current_try}" # pad with zeros as needed
  end

end
