class Upload < ActiveRecord::Base
  def self.with_meaning
    where.not(meaning: ["no meaning", ""])
  end
end
