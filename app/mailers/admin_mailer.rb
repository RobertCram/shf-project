class AdminMailer < ApplicationMailer


  def new_shf_application_received(new_shf_app, admin)

    @shf_app = new_shf_app

    set_mail_info __method__, admin

    mail to: @recipient_email, subject: t('application_mailer.admin.new_application_received.subject')

  end

  
end
