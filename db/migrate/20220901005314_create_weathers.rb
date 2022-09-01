# frozen_string_literal: true

# CreateWeathers
class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.string :token, null: false
      t.string :location
      t.jsonb :data, null: false, default: '{}'

      t.timestamps
    end

    add_index :weathers, :token
    add_index :weathers, :data, using: :gin
  end
end
