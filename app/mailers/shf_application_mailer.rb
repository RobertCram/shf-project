class ShfApplicationMailer < AbstractMembershipInfoMailer


  def acknowledge_received(shf_application)

    send_mail_for __method__, shf_application, t('application_mailer.shf_application.acknowledge_received.subject')

  end


  def accepted(shf_application)

    send_mail_for __method__, shf_application, t('application_mailer.shf_application.accepted.subject')

  end


end
