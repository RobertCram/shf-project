module AdminOnly
  
  class MemberAppWaitingReason < ApplicationRecord

    validates_presence_of :name_sv


    def self.default_name_method
      :name_sv
    end

    def self.default_description_method
      :description_sv
    end

  end

end

