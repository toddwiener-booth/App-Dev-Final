class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.string :team_bet
      t.string :favorite_or_underdog
      t.string :opposing_team
      t.string :win_loss
      t.float :odds
      t.float :wager
      t.integer :owner_id
      t.float :money_won_lost
      t.integer :team_id_bet
      t.integer :opposing_team_id
      t.integer :likes_count

      t.timestamps
    end
  end
end
