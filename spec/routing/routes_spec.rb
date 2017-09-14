require 'rails_helper'

RSpec.shared_examples "a swedish named resource" do |swedish_name, controller|

  let(:new)  { 'ny' }
  let(:edit) { 'redigera' }

  it "/#{swedish_name} = #index" do
    assert_routing({path: "#{swedish_name}", method: :get}, {controller: controller, action: 'index'})
  end

  it "/#{swedish_name}/ny = #create" do
    assert_routing({path: "#{swedish_name}", method: :post}, {controller: controller, action: 'create'})
  end

  it "/#{swedish_name}/ny = #new" do
    assert_routing({path: "#{swedish_name}/#{new}", method: :get}, {controller: controller, action: 'new'})
  end

  it "/#{swedish_name}/i/redigera = #edit" do
    assert_routing({path: "#{swedish_name}/1/#{edit}", method: :get}, {controller: controller, action: 'edit', id: '1'})
  end

  it "/#{swedish_name}/i = #show" do
    assert_recognizes({controller: controller, action: 'show', id: '1'}, "/#{swedish_name}/1")
   # /ansokan/:id/accept
    #assert_generates({})
    #assert_routing({path: "#{swedish_name}/1", method: :get}, {controller: controller, action: 'show', id: '1'})
  end

  it "/#{swedish_name}/i = #update" do
    assert_routing({path: "#{swedish_name}/1", method: :patch}, {controller: controller, action: 'update', id: '1'})
  end

  it "/#{swedish_name}/i = #update" do
    assert_routing({path: "#{swedish_name}/1", method: :put}, {controller: controller, action: 'update', id: '1'})
  end

  it "/#{swedish_name}/i = #destroy" do
    assert_routing({path: "#{swedish_name}/delete", method: :delete}, {controller: controller, action: 'destroy', id: 'delete'})
  end

end

RSpec.describe "swedish named routes", :type => :routing do

  describe 'companies path = hundforetag, controller: CompaniesController' do
    it_should_behave_like "a swedish named resource", 'hundforetag', 'companies'
  end

  describe 'membership_applications path = ansokan, controller: MembershipApplicationsController' do

    describe 'change membership application state actions' do
      let(:controller) {'membership_applications'}
      let(:swedish_name) {'ansokan'}

      it 'accept - POST' do
        assert_recognizes({controller: controller, action: 'accept', id: '1'}, {path: "/#{swedish_name}/1/accept", method: :post})
      end

      it 'accept - GET should just show the membership application' do
        assert_recognizes({controller: controller, action: 'show', id: '1'}, "/#{swedish_name}/1/accept")
      end

      it 'reject - POST' do
        assert_recognizes({controller: controller, action: 'reject', id: '1'}, {path: "/#{swedish_name}/1/reject", method: :post})
      end

      it 'reject - GET should just show the membership application' do
        assert_recognizes({controller: controller, action: 'show', id: '1'}, "/#{swedish_name}/1/reject")
      end

      it 'need-info - POST' do
        assert_recognizes({controller: controller, action: 'need_info', id: '1'}, {path: "/#{swedish_name}/1/need-info", method: :post})
      end

      it 'need-info - GET should just show the membership application' do
        assert_recognizes({controller: controller, action: 'show', id: '1'}, "/#{swedish_name}/1/need-info")
      end

      it 'cancel-need-info - POST' do
        assert_recognizes({controller: controller, action: 'cancel_need_info', id: '1'}, {path: "/#{swedish_name}/1/cancel-need-info", method: :post})
      end

      it 'cancel-need-info - GET should just show the membership application' do
        assert_recognizes({controller: controller, action: 'show', id: '1'}, "/#{swedish_name}/1/cancel-need-info")
      end

    end

  end

  describe 'business_categories path = kategori, controller: BusinessCategoriesController' do
    it_should_behave_like "a swedish named resource", 'kategori', 'business_categories'
  end

end
