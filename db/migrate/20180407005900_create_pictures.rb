class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :file_data
      t.string :tags, array: true, default: []
      t.integer :user_id, default: nil

      t.timestamps
    end
  end
end
