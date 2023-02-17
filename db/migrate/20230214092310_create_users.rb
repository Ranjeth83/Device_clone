class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :lastname
      t.string :email
      t.integer :mobile
      t.date :dob
      t.string :encrypted_password

      t.timestamps
    end
  end
end
