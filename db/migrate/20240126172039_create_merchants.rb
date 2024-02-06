# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :reference, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
