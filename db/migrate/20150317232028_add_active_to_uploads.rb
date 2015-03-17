class AddActiveToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :active, :boolean, default: false
  end
end
