# PREREQUISITE MIGRATIONS:
# None

# PREREQUISITE RAKE TASKS:
# None

namespace :shf do
  namespace :addresses do

    desc "Delete invalid addresses in DB"
    task delete_invalid: :environment do

      LOG_FILE = 'log/delete_invalid_addresses'

      ActivityLogger.open(LOG_FILE, 'SHF_TASK', 'Delete addresses') do |log|

        log.record('info', "Checking validity of #{Address.count} addresses.")

        deletes = 0

        Address.all.each do |address|
          next if address.valid?

          log.record('info', "Deleting Address ID: #{address.id}")
          log.record('info', "#{address.inspect}")

          address.delete

          deletes += 1
        end

        log.record('info', "Deleted #{deletes} addresses.")
      end
    end
  end
end
