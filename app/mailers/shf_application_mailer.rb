class ShfApplicationMailer < AbstractMembershipInfoMailer


  def acknowledge_received(shf_application)

    send_mail_for __method__, shf_application, t('application_mailer.shf_application.acknowledge_received.subject')

  end


  def app_approved(shf_application)
    @branding_fee_paid = shf_application.company&.branding_license?

    send_mail_for __method__, shf_application, t('application_mailer.shf_application.app_approved.subject')

  end


end
