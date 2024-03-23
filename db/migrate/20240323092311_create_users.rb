class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, force: :cascade do |t|
      t.string :address, null: false, index: { unique: true }

      t.timestamps
    end
  end
end