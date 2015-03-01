class AddMeaningToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :meaning, :string
  end
end
