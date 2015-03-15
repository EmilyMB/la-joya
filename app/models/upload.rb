class Upload < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  # validates :meaning, presence: true
  validates :user_id, presence: true

  def self.with_meaning
    where.not(meaning: ["no meaning", ""])
  end
end
