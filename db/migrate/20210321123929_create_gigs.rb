class CreateGigs < ActiveRecord::Migration[5.2]
  def change
    create_table :gigs do |t|
      t.string :venue
      t.string :date
      t.string :time
      t.integer :user_id
    end
  end
end
