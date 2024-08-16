require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have first_name, last_name and email" do
    user = build(:user, first_name: nil, last_name: nil, email: nil)
    expect(user).to_not be_valid
  end

  it "should have a unique email" do
    email = Faker::Internet.email
    create(:user, email: email)
    user = build(:user, email: email)
    expect(user).to_not be_valid
  end

  it "should have an availability after creation" do
    user = create(:user)
    expect(user.availabilities.count).to eq(1)
  end
end
