#require 'spec_helper'

#describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end


# spec/requests/static_pages_spec.rb

require 'spec_helper'

describe "Static pages" do



   # it "should have the content 'Sample App'" do
   #   visit '/static_pages/home'
   #   expect(page).to have_content('Sample App')
   # end

   # it "should have the right title" do
   #   visit '/static_pages/home'
   #   expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
   # end
  subject { page }

    let (:base_title ) { "Ruby on Rails Tutorial Sample App" }
    describe "Home page" do
      before { visit root_path }
      it { should have_content('Sample App') }
      it { should have_title(full_title('')) }
      it { should_not have_title('| Home') }
    end

  describe "Help page" do
    before { visit help_path }
    it { should have_content('Help') }
    it { should have_title("Ruby on Rails Tutorial Sample App | Help") }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_content('About Us') }
    it { should have_title("Ruby on Rails Tutorial Sample App | About Us") }
  end




end