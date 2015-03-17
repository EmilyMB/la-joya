require "rails_helper"

describe Upload, type: "model" do
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

  it "has a method to show only public data" do
    3.times { create(:upload) }
    create(:upload_without_meaning)
    public_words = Upload.public_words
    public_methods = ["id", "url", "meaning", "meaning_en"]
    non_public_methods = ["created_at", "updated_at", "user_id"]

    expect(public_words.length).to eq(3)
    public_methods.each do |method|
      expect(public_words[0].respond_to?(method.to_sym)).to be_truthy
    end
    non_public_methods.each do |method|
      expect(public_words[0].respond_to?(method.to_sym)).to be_falsey
    end
  end
end
