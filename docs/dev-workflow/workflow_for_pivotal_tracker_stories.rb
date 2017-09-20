require 'aasm'

# This is the state machine that represents how we use PivotalTracker.
# You can use the 'aasm_statecharts' gem to create a diagram from it.

# The weedySeaDragon's (Ashley Engelund's) version of 'aasm_statecharts'
# was used to generate the .png diagram for this.  Use the following command:
#  (Note that you should be in the Rails.root directory (e.g the directory
#   above /app.)
#
#   bundle exec aasm_statecharts --include ./docs/dev-workflow workflow_for_pivotal_tracker_stories --directory ./docs/wiki --config ./docs/dev-workflow/aasm-diagram-blue-green.yml --table
#
# where:
#  '--include ./app/models'  means "include path" ./app/models
#  'pivotal_tracker_feature' is the model to be diagrammed (it's actually the name of the .rb file for the model)
#  '--directory ./docs/dev-workflow'  means "output to the directory " ./docs/dev-workflow
#  '--config aasm-diagram-blue-green.yml' means use the configuration file ./docs/dev-workflow/aasm-diagram-blue-green.yml
#  '--table'  means "include a table in the diagraph generated"
#
#
# The weedySeaDragon version of `aasm_statecharts` is in the Gemfile.
#
# Using dot:  to create a .png file from a .dot file:
#  dot  -Tpng -O input_dot_file.dot
#


class WorkflowForPivotalTrackerStories

  include AASM

  aasm do

    state :picked_a_story_from_backlog, enter: :start_work_on_story,
          initial: true

    state :discussed

    state :points_assigned

    state :started, enter: [:press_PT_Start_button, :write_feature_or_spec], exit: :all_tests_pass
    
    state :finished_scrum_review, enter: :explained_and_demoed_in_scrum_meeting


    state :deployed_to_Heroku, enter: [:press_PT_Finished_button_in_meeting, :development_branch_changes_merged_to_Heroku]

    state :waiting_for_client_review

    state :client_accepted, enter: :press_PT_Accepted_button_in_meeting

    state :client_rejected, enter: :press_PT_Rejected_button_in_meeting

    state :deployed_to_production, enter: :merge_changes_from_Heroku_to_DigitalOcean,
          final: true



    event :discuss_task do
      transitions from: :picked_a_story_from_backlog, to: :discussed
      transitions from: :client_rejected, to: :discussed
    end

    event :vote_on_feature do
      transitions from: :discussed, to: :points_assigned, guard: [:is_client_facing, :at_least_3_people_vote]
    end

    event :start_work do
      transitions from: :points_assigned, to: :started
      transitions from: :discussed, to: :started, guard: :is_not_client_facing
    end

    event :finished_PR do
      transitions from: :started, to: :finished_scrum_review
    end


    event :approved_in_scrum_meeting do
   #   transitions from: :finished_scrum_review, to: :waiting_for_client_review, guard: :is_client_facing
      transitions from: :finished_scrum_review, to: :deployed_to_Heroku #, guard: :is_not_client_facing
    end


    event :SHF_team_says_not_finished do
      transitions from: :finished_scrum_review, to: :started
    end


    event :waiting_for_client_review_day do
      transitions from: :deployed_to_Heroku, to: :waiting_for_client_review, guard: :is_client_facing
    end


    event :client_accepts do
      transitions from: :waiting_for_client_review, to: :client_accepted
    end

    event :client_rejects do
      transitions from: :waiting_for_client_review, to: :client_rejected
    end





    event :deploy do
      transitions from: :client_accepted, to: :deployed_to_production
      transitions from: :deployed_to_Heroku, to: :deployed_to_production, guard: :is_not_client_facing
    end

  end




end
