class CreateMonitoringRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :monitoring_requests do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
