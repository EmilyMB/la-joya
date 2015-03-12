class Upload < ActiveRecord::Base

  def self.with_meaning
    where("meaning != ?", "no meaning")
  end
end
