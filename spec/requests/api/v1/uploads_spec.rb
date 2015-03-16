describe "Words API" do
  it 'sends a list of words' do
    FactoryGirl.create_list(:upload, 10)

    get '/api/v1/words'

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.length).to eq(10)
  end

  it 'sends only sends words with a Spanish meaning' do
    FactoryGirl.create_list(:upload, 8)
    FactoryGirl.create_list(:upload_without_meaning, 5)

    get '/api/v1/words'

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.length).to eq(8)
  end

  it 'sends only sends id, Spanish, English, and url' do
    FactoryGirl.create_list(:upload, 8)
    FactoryGirl.create_list(:upload_without_meaning, 5)

    get '/api/v1/words'

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json[0].keys.include?("user_id")).to be_falsey
    expect(json[0].keys.include?("created_at")).to be_falsey
    expect(json[0].keys.include?("updated_at")).to be_falsey
    expect((json[0].keys & ["meaning", "meaning_en", "url", "id"])).to be_truthy
  end

  it 'sends a single word' do
    words = FactoryGirl.create_list(:upload, 10)
    word = words.first
    second_word = words.second

    get "/api/v1/words/#{word.id}"

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.class).to be(Hash)

    assert_equal word.id, json["id"]
    assert_equal word.meaning, json["meaning"]
    assert_equal word.meaning_en, json["meaning_en"]
  end

  it 'sends a single word with only public meanings' do
    words = FactoryGirl.create_list(:upload, 10)
    word = words.first

    get "/api/v1/words/#{word.id}"

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json.keys.include?("user_id")).to be_falsey
    expect(json.keys.include?("created_at")).to be_falsey
    expect(json.keys.include?("updated_at")).to be_falsey
    expect((json.keys & ["meaning", "meaning_en", "url", "id"])).to be_truthy
  end
end
