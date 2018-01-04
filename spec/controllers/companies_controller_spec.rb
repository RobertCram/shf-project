require 'rails_helper'


RSpec.describe CompaniesController, type: :controller do

  describe '#index will fix_FB_changed_params' do

    it "does not change URL if there are no query ('q') parameters" do
      no_query_params = { "utf8" => "✓" }

      expected_fixed = { "utf8" => "✓",
                         "controller" => "companies",
                         "action" => "index",
      }

      get :index, params: no_query_params

      expect(subject.params.to_unsafe_h).to eq expected_fixed

    end

    it 'q parameters that are a Hash are converted to Array with the Hash values' do

      fb_mangled_params = { "utf8" => "✓",
                            "q" => {
                                "business_categories_id_in" => { "0" => "1", "1" => "2", "2" => "3" }
                            }
      }

      expected_fixed_q = { "business_categories_id_in" => ["1", "2", "3"] }

      get :index, params: fb_mangled_params
      expect(subject.params.to_unsafe_h['q']).to eq expected_fixed_q
    end

    it 'empty values do not need to be retained)' do

      fb_mangled_params = { "utf8" => "✓",
                            "q" => {
                                "business_categories_id_in" => { "0" => "1", "1" => "2", "2" => "3" },
                                "addresses_region_id_in" => { "0" => "6" },
                                "addresses_kommun_id_in" => { "0" => nil, "1" => "" },
                                "name_in" => { "0" => nil } },
                            "commit" => "Sök" }

      expected_fixed_q = { "business_categories_id_in" => ["1", "2", "3"],
                           "addresses_region_id_in" => ["6"],
                           "addresses_kommun_id_in" => ["", ""],
                           "name_in" => [""] }


      get :index, params: fb_mangled_params

      expect(subject.params.to_unsafe_h['q']).to match expected_fixed_q
    end

  end

end
