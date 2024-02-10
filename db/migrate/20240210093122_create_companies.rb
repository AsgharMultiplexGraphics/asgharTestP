class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :owner_id

      t.timestamps
    end

    add_column :users,:company_id,:integer
  end
end
