class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :favorite_team
      t.float :default_bet
      t.float :total_balance
      t.integer :bets_count

      t.timestamps
    end
  end
end
