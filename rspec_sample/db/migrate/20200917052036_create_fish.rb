class CreateFish < ActiveRecord::Migration[5.1]
  def change
    create_table :fish do |t|
      t.string :date
      t.string :time
      t.string :locate
      t.string :title
      t.string :person
      t.string :link
      t.timestamps
    end
  end
end
