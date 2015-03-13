require "rails_helper"

describe User, type: "model" do
  it "is invalid without a name" do
    user = build(:user, name: nil)

    expect(user).not_to be_valid
  end

  it "is invalid without a first name" do
    user = build(:user, first_name: nil)

    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)

    expect(user).not_to be_valid
  end

  it "is invalid without a provider" do
    user = build(:user, provider: nil)

    expect(user).not_to be_valid
  end

  it "has associated uploads" do
    user = create(:user)
    3.times { user.uploads << create(:upload) }
    2.times { create(:upload) }

    expect(Upload.count).to eq(5)
    expect(user.uploads.count).to eq(3)
  end
end
