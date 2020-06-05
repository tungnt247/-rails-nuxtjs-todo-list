class CreateBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklists do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
  end
end
