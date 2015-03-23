class ProcessUpload
  attr_reader :input, :user_id

  def initialize(input_file, user_id)
    @input = input_file
    @user_id = user_id
  end

  def call
    obj = S3_BUCKET.objects[input.original_filename]
    obj.write(file: input, acl: :public_read)
    upload = Upload.new(url: obj.public_url,
                        name: obj.key,
                        meaning: "no meaning",
                        meaning_en: "no meaning",
                        user_id: user_id)
    upload.save
  end
end
