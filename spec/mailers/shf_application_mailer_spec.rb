require 'rails_helper'
require 'email_spec/rspec'


require File.join(__dir__, 'shared_email_tests')

require_relative './previews/shf_application_mailer_preview'

# Ensure that the mail can be created
#  and the subject, recipient, and greeting are correct
#
RSpec.describe ShfApplicationMailer, type: :mailer do

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let!(:test_user) { create(:user, email: 'user@example.com') }


  describe '#accepted' do

    let(:accepted_app) { create(:shf_application, :accepted, user: test_user) }
    let(:email_sent) { ShfApplicationMailer.accepted(accepted_app) }

    it_behaves_like 'a successfully created email to a member',
                    I18n.t('application_mailer.shf_application.accepted.subject'),
                    'user@example.com',
                    I18n.t('application_mailer.greeting', greeting_name: 'Firstname Lastname') do
      let(:email_created) { email_sent }
    end

  end


  describe '#acknowledge_received' do

    let(:received_app) { create(:shf_application, user: test_user) }
    let(:email_sent) { ShfApplicationMailer.acknowledge_received(received_app) }

    it_behaves_like 'a successfully created email to a member',
                    I18n.t('application_mailer.shf_application.acknowledge_received.subject'),
                    'user@example.com',
                    I18n.t('application_mailer.greeting', greeting_name: 'Firstname Lastname') do
      let(:email_created) { email_sent }
    end

  end


  it 'has a previewer' do
    expect(ShfApplicationMailerPreview).to be
  end

end
