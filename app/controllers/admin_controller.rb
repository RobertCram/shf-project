class AdminController < ApplicationController
  before_action :authorize_admin


  def index
    @membership_applications = MembershipApplication.includes(:user).all
  end


  # export membership_appplications
  def export_ansokan_csv

    begin
      @membership_applications = MembershipApplication.includes(:user).all

      export_name = "shf-ankosan-#{Time.now.strftime('%Y-%m-%d--%H-%M-%S')}.csv"

      send_data(export_str(@membership_applications), filename: export_name, type: "text/plain" )

      helpers.flash_message(:notice, t('.success'))

    rescue  => e

      helpers.flash_message(:alert, "#{t('.error')} [#{e.message}]")
      redirect_to(request.referer.present? ? :back : root_path)

    end

  end


  private

  def authorize_admin
    AdminPolicy.new(current_user).authorized?
  end


  def export_str(membership_apps)

    out_str = export_header_str

    membership_apps.each do |m_app|
      out_str << "#{m_app.contact_email},#{m_app.user.first_name},#{m_app.user.last_name},#{m_app.membership_number},"
      out_str << t("membership_applications.state.#{m_app.state}")
      out_str << ','

      # add the business categories, all surrounded by double-quotes
      out_str << '"' + m_app.business_categories.map(&:name).join(', ') + '"'
      out_str << ','

      # a company name may have commas, so surround with quotes so spreadsheets recognize it as one string and not multiple comma-separated value
      out_str << (m_app.company.nil? ?  '' : "\"#{m_app.company.name}\"")
      out_str << ','

      # add the SE postal service mailing address info as a CSV string
      out_str << m_app.se_mailing_csv_str

      out_str << "\n"
    end

    out_str.encode('UTF-8')
  end


  def export_header_str

    # build the header string from strings in the locale file

    header_member_strs = ['activerecord.attributes.membership_application.contact_email',
                          'activerecord.attributes.membership_application.first_name',
                          'activerecord.attributes.membership_application.last_name',
                          'activerecord.attributes.membership_application.membership_number',
                          'activerecord.attributes.membership_application.state',
                          'activerecord.models.business_category.other',
                          'activerecord.models.company.one',
                          'activerecord.attributes.address.street',
                          'activerecord.attributes.address.post_code',
                          'activerecord.attributes.address.city',
                          'activerecord.attributes.address.kommun',
                          'activerecord.attributes.address.region',
                          'activerecord.attributes.address.country',
    ]

    out_str = ''

    out_str << header_member_strs.map{| header_str | "'#{t(header_str).strip}'" }.join(',')

    out_str << "\n"

  end


end
