require "rails_helper"

RSpec.describe "Looking For Work", type: :system do
  let(:user) { create(:user) }
  let(:tag) { create(:tag, name: "hiring") }

  before do
    puts "-------"
    puts user.valid?
    puts user.errors.messages
    puts "-------"
    login_as(user, :scope => :user)
    tag
  end

  it "user selects looking for work and autofollows hiring tag" do
    puts "-------"
    puts user.text_color_hex
    puts tag.text_color_hex
    puts user.bg_color_hex
    puts "-------"
    visit "/settings"
    page.check "Looking for work"
    expect(page).to have_text("SUBMIT")
    perform_enqueued_jobs do
      click_button("SUBMIT")
    end
    expect(page).to have_text("Your profile was successfully updated")
    expect(user.follows.count).to eq(1)
  end
end
