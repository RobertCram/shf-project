# Preview all emails at http://localhost:3000/rails/mailers

require_relative 'pick_random_helpers'

class MemberMailerPreview < ActionMailer::Preview

  include PickRandomHelpers


  def membership_granted
    approved_app = random_shf_app(:accepted)
    MemberMailer.membership_granted(approved_app.user)
  end


end
