class NullTrueUserIdToOffers < ActiveRecord::Migration[6.1]
  def change
    change_column :offers, :user_id, :bigint, null: true
  end
end
