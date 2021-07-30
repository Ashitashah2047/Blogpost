class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :title
      t.string :body
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
