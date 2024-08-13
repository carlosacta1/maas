class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
