# Preview all emails at http://localhost:3000/rails/mailers

require_relative 'pick_random_helpers'


class AdminMailerPreview < ActionMailer::Preview

  include PickRandomHelpers


  def new_shf_application_received
    admin = User.find_by(admin: true)

    app = random_shf_app
    upload_random_num_files(app)

    AdminMailer.new_shf_application_received(app, admin)
  end


end
