require "rails_helper"

describe Upload, type: "model"  do

  it "is invalid without a url" do
    upload = build(:upload, url: nil)

    expect(upload).not_to be_valid
  end

  it "is invalid without a meaning" do
    upload = build(:upload, meaning: nil)

    expect(upload).not_to be_valid
  end

  it "is invalid without an associated user" do
    upload = build(:upload, user_id: nil)

    expect(upload).not_to be_valid
  end

  it "has a method to remove uploads with no meaning" do
    3.times { create(:upload) }
    create(:upload_without_meaning)

    expect(Upload.count).to eq(4)
    expect(Upload.with_meaning.count).to eq(3)
  end
end
