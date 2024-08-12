class CreateServiceUserMonitors < ActiveRecord::Migration[7.0]
  def change
    create_table :service_user_monitors do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :schedule, null: false

      t.timestamps
    end
  end
end
