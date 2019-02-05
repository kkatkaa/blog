class CreateCommentsRaitings < ActiveRecord::Migration[5.2]
  def change
    create_table :comments_raitings do |t|
      t.integer :raiting
      t.references :comment, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.index [:user_id, :comment_id], unique: true
      t.timestamps
    end
  end
end
