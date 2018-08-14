class CreateEnquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :enquiries do |t|
      t.belongs_to :user, foreign_key: true
      t.string :source
      t.text :message

      t.timestamps
    end
  end
end
