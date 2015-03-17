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

  it "is not an admin by default" do
    user = create(:user)

    expect(user.admin?).to be_falsey
  end

  it "is be an admin" do
    user = create(:user)

    user.update_attributes(admin: true)

    expect(user.admin?).to be_truthy
  end
end
