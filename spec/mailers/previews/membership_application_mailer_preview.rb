# Preview all emails at http://localhost:3000/rails/mailers

require_relative 'pick_random_helpers'

class MembershipApplicationMailerPreview < ActionMailer::Preview

  include PickRandomHelpers

  def accepted
    MembershipApplicationMailer.accepted(random_member_app(:accepted))
  end


  def acknowledge_received
    MembershipApplicationMailer.acknowledge_received(random_member_app)
  end


end
