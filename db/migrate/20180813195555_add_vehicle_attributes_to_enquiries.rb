class AddVehicleAttributesToEnquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :vehicle_attributes, :jsonb, default: {}
    add_column :enquiries, :identifier, :string, null: false
  end
end
