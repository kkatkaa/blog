class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :article, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.index [:user_id, :article_id], unique: true
      t.timestamps
    end
  end
end
