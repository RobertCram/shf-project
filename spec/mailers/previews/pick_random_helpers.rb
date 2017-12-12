module PickRandomHelpers



  # return a random new membership application
  def random_member_app(application_state = :new)

    app_ids = MembershipApplication.where(state: application_state).pluck(:id)

    rand_id_index = Random.rand(app_ids.count)

    MembershipApplication.find( app_ids[rand_id_index])

  end


  def random_user
    user_ids = User.pluck(:id)

    rand_id_index = Random.rand(user_ids.count)
    User.find( user_ids[rand_id_index] )

  end


  FIXTURE_DIR = File.join("#{Rails.root}",'spec','fixtures','uploaded_files')

  # Upload a random number of files for the membership application
  # Upload at least [min] files (where minimum is 1 by default)
  # and at most [max] file.
  # If the application already has uploaded files, add as needed to get to the random number.
  # If the application already has has more than the max number or more than the random number of files,
  # just go with what it has. (Don't delete anything; those files might be there for some other test or reason.)
  def upload_random_num_files(app,  min: 1, max: 5)

    random_num_files = Random.rand(min..max)

    if app.uploaded_files.count < random_num_files

      (random_num_files - app.uploaded_files.count).times do | i |

        file_txt =  File.open(File.join(FIXTURE_DIR, "uploaded-#{i}.txt"), 'w'){ |f| f.puts "temp text file number #{i}"}

        uploaded_file = UploadedFile.create(actual_file: file_txt, membership_application: app, actual_file_file_name:  "uploaded-#{i}.txt")
        app.uploaded_files << uploaded_file
      end

    end

  end


end


