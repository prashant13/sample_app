require 'rails_helper'

RSpec.describe "FriendlyForwardings", :type => :request do
  describe "GET /friendly_forwardings" do
    it "should forward to the requested page after signin" do
    	user = Factory(:user)
    	visit edit_user_path(user)
    	#The test automatically follows the redirect to the signin page
    	fill_in :email, :with => user.email
    	fill_in :password, :with => user.password
    	click_button
    	#The test follows the redirect again, this time to the users/edit.
    	expect(response).to render_template('users/edit')
    end
  end
end
