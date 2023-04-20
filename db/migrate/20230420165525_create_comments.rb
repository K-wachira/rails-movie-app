class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :comment_text
      t.integer :likes
      t.integer :dislikes
      t.boolean :spoiler_alert

      t.timestamps
    end
  end
end
