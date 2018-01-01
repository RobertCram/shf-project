require 'rails_helper'

RSpec.describe BusinessCategory, type: :model do

  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:business_category)).to be_valid
    end
  end

  describe 'DB Table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :description }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:companies).through(:shf_applications) }
    it { is_expected.to have_and_belong_to_many(:shf_applications) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
