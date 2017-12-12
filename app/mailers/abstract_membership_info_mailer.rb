# This class abstracts methods common to mailer classes that send out mails
# based on MembershipApplications.
#
class AbstractMembershipInfoMailer < ApplicationMailer


  private

  def send_mail_for(method_name, member_app, subject )

    set_mail_info method_name, member_app
    mail to: @recipient_email, subject: subject

  end


  def set_mail_info(method_sym, member_app)

    super(method_sym, member_app.user)
    @member_app = member_app

  end


end
