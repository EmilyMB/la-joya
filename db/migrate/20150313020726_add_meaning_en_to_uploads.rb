class AddMeaningEnToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :meaning_en, :string
  end
end
