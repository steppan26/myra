class AddNullTrueServiceIdToOffers < ActiveRecord::Migration[6.1]
  def change
    change_column :offers, :service_id, :bigint, null: true
  end
end
