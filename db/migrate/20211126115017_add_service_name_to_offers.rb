class AddServiceNameToOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :service_name, :string
  end
end
