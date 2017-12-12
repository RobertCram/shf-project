class AdminMailer < ApplicationMailer


  def new_member_application_received(new_member_app, admin)

    @member_app = new_member_app

    set_mail_info __method__, admin

    mail to: @recipient_email, subject: t('application_mailer.admin.new_application_received.subject')

  end

  
end
