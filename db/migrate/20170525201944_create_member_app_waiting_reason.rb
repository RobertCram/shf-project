class CreateMemberAppWaitingReason < ActiveRecord::Migration[5.1]


  def change

    create_table :member_app_waiting_reasons, comment: "reasons why SHF is waiting for more info from applicant. Add more columns when more locales needed." do |t|
      
      t.string :name_sv,                                  comment: "name of the reason in svenska/Swedish"
      t.string :description_sv,                           comment: "description for the reason in svenska/Swedish"
      t.string :name_en,                                  comment: "name of the reason in engelsk/English"
      t.string :description_en,                           comment: "description for the reason in engelsk/English"
      t.boolean :is_custom, null: false, default: false,  comment: "was this entered as a new 'custom' reason?"

      t.timestamps
    end

  end


end
