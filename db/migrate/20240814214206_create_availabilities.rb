class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true

      t.string :start_day, null: false, default: 'Monday'
      t.string :end_day, null: false, default: 'Friday'

      t.time :start_time, null: false, default: '08:00'
      t.time :end_time, null: false, default: '17:00'

      t.boolean :temporarily_unavailable, null: false, default: false

      t.timestamps
    end
  end
end
