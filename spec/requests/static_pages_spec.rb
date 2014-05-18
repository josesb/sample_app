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

describe "Static pages" do   #describe las paginas estaticas
  let (:base_title ) { "Ruby on Rails Tutorial Sample App" }

  subject {page}

  describe "Home page" do     #describe las paginas home
    before { visit root_path }  #pag 50 DAN 13
    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }   # Se agrega en pag 54 DAN_13 junto con utilities.rb
    # it { should have_title("Ruby on Rails Tutorial Sample App") }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }  #pag 50 DAN 13
    it { should have_content('Help')}
    it { should have_title(full_title('')) }
    #it { should have_title("Ruby on Rails Tutorial Sample App") }
    # it { should_not have_title('| Help') }

  end

  describe "About page" do
    before { visit about_path }  #pag 50 DAN 13
    it { should have_content('About')}
    it { should have_title(full_title('')) }
    #it { should have_title("Ruby on Rails Tutorial Sample App") }
    #it { should_not have_title('| About') }
  end

  describe "Contact page" do
    before { visit contact_path }  #pag 50 DAN 13
    it { should have_content('Contact')}
    it { should have_title(full_title('')) }
    #it { should have_title("Ruby on Rails Tutorial Sample App") }
    #it { should_not have_title('| Contact') }
  end


end


