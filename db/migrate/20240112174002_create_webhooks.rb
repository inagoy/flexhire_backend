class CreateWebhooks < ActiveRecord::Migration[7.1]
  def change
    create_table :webhooks do |t|
      t.string :source
      t.json :data
      t.string :message
      t.string :event

      t.timestamps
    end
  end
end
