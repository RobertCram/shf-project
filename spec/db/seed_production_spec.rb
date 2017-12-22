require 'rails_helper'

RSpec.describe 'load admin.email, admin.password, business categories, regions and kommuns from ENV in production' do

  env_shf_email = 'SHF_ADMIN_EMAIL'
  env_shf_pwd = 'SHF_ADMIN_PWD'
  admin_email = 'the-shfadmin@shf.org'
  admin_pwd = 'insecure-password'

  SEED_ERROR = 'Seed ERROR: Could not load either admin email or password. NO ADMIN was created!'


  describe 'happy path - all is valid' do

    before(:all) do
      DatabaseCleaner.start
      RSpec::Mocks.with_temporary_scope do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        stub_const('ENV', {env_shf_email => admin_email, env_shf_pwd => admin_pwd})
        SHFProject::Application.load_tasks
        SHFProject::Application.load_seed
      end
    end

    after(:all) do
      DatabaseCleaner.clean
      Rake::Task['shf:load_regions'].reenable
      Rake::Task['shf:load_kommuns'].reenable
    end

    let(:admin_in_db) { User.find_by_email(admin_email) }

    it "#{admin_email} is in the db" do
      expect(admin_in_db).not_to be_nil
    end

    it "#{admin_email} is an admin (admin=true) in db" do
      expect(admin_in_db.admin).to be_truthy
    end

    it "admin email is = ENV['SHF_ADMIN_EMAIL']" do
      expect(admin_in_db.email).to eq(admin_email)
    end

    it "admin email is = ENV['SHF_ADMIN_PWD']" do
      # User.find(1).valid_password?('password123')
      expect(admin_in_db.valid_password?(admin_pwd)).to be_truthy
    end

    it "admin is the only user in the db" do
      expect(User.all.size).to eq(1)
    end

    it "business categories are in the db" do
      expect(BusinessCategory.all.size).to eq(11)
    end

    it "regions are in the db" do
      expect(Region.all.size).to eq(23)
    end

    it "kommuns are in the db" do
      expect(Kommun.all.size).to eq(290)
    end

    it "adresses are not in the db" do
      expect(Address.all.size).to eq(0)
    end

    it "companies are not in the db" do
      expect(Company.all.size).to eq(0)
    end

    it "memberships applications are not in the db" do
      expect(ShfApplication.all.size).to eq(0)
    end

  end


  describe 'sad path - things go wrong' do

    before(:each) do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
    end

    it "ENV[#{env_shf_email}] not found" do
      stub_const('ENV', {env_shf_pwd => admin_pwd})

      expect { Rails.application.load_seed }.to raise_exception SEED_ERROR
    end

    it "ENV[#{env_shf_email}] is an empty string" do
      stub_const('ENV', {env_shf_email => '', env_shf_pwd => admin_pwd})

      expect { Rails.application.load_seed }.to raise_exception SEED_ERROR
    end

    it "ENV[#{env_shf_pwd}] not found" do
      stub_const('ENV', {env_shf_email => admin_email})

      expect { Rails.application.load_seed }.to raise_exception SEED_ERROR
    end

    it "ENV[#{env_shf_pwd}] is an empty string" do
      stub_const('ENV', {env_shf_email => admin_email, env_shf_pwd => ''})

      expect { Rails.application.load_seed }.to raise_exception SEED_ERROR
    end
  end

end
