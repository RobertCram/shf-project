And(/^the following applications exist:$/) do |table|
 table.hashes.each do |hash|
   attributes = hash.except('user_email', 'categories')
   user = User.find_by(email: hash[:user_email].downcase)
   if hash['state'] == 'accepted' || hash['state'] == 'rejected'
     company = Company.find_by(company_number: hash['company_number'])
     unless company
       company = FactoryGirl.create(:company, company_number: hash['company_number'])
     end
   end
   contact_email = hash['contact_email'] && ! hash['contact_email'].empty? ? 
                   hash['contact_email'] : hash[:user_email]
   ma = FactoryGirl.create(:membership_application,
                            attributes.merge(user: user,
                            company: company,
                            contact_email: contact_email))
   ma.state = hash['state'].to_sym if hash.has_key?('state')
   if hash['categories']
     categories = []
     for category_name in hash['categories'].split(/\s*,\s*/)
       categories << BusinessCategory.find_by_name(category_name)
     end
     ma.business_categories = categories
   end
 end
end

And(/^the following simple applications exist:$/) do |table|
  table.hashes.each do |hash|
    ma = FactoryGirl.build(:membership_application,
                           company_number: hash['company_number'],
                           contact_email: hash['user_email'],
                           state: hash['state'])
    ma.save(validate: false)
  end
end
