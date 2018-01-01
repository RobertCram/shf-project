# This class abstracts methods common to mailer classes that send out mails
# based on ShfApplications.
#
class AbstractMembershipInfoMailer < ApplicationMailer


  private

  def send_mail_for(method_name, shf_app, subject )

    set_mail_info method_name, shf_app
    mail to: @recipient_email, subject: subject

  end


  def set_mail_info(method_sym, shf_app)

    super(method_sym, shf_app.user)
    @shf_app = shf_app

  end


end
