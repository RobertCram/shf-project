class MembershipApplicationMailer < AbstractMembershipInfoMailer


  def acknowledge_received(member_application)

    send_mail_for __method__, member_application, t('application_mailer.membership_application.acknowledge_received.subject')

  end


  def app_approved(member_application)
    @branding_fee_paid = member_application.company&.branding_license?

    send_mail_for __method__, member_application, t('application_mailer.membership_application.app_approved.subject')

  end


end
