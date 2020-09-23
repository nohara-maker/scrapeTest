class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :date
      t.string :locate
      t.string :title
      t.string :person
      t.string :link

      t.timestamps
    end
  end
end
