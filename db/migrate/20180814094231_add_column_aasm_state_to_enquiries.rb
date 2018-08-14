class AddColumnAasmStateToEnquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :aasm_state, :string
  end
end
