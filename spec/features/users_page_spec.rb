require 'rails_helper'

# OMAT MODUULIT
require 'helpers' # helpers.rb
include Helpers # MYÖS MODUULI ITSE
# END OMAT MODUULIT


describe "User" do
  before :each do
    FactoryBot.create(:user)
  end
  describe("Signing up") do
    it("is done with right credentials") do
      sign_in(username: "Anton", password: "Test123")
      save_and_open_page
      expect(page).to(have_content("Anton"))
    end

    it("doesnt work with incorrect credentials") do
      sign_in(username: "Anton", password: "thiswillfail")

      # HUOM SYNTAKSI!!
      expect{
        click_button("Log in")
      }.to(change{User.count}.by(0))

      save_and_open_page
      expect(page).to(have_content("Username and/or password mismatch"))
      expect(current_path).to(eq(signin_path))
    end

    it("adds a new user when done with correct new credentials") do
      sign_up(username: "AntonM", password: "NewTest123", password_confirmation: "NewTest123")
      expect(User.count).to(eq(2)) # Luotiin 1 aluksi, nyt pitäisi olla 2
    end
  end
end