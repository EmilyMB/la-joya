class AddUserIdToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :user, index: true
  end
end
