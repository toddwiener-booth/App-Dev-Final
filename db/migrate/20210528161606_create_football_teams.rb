class CreateFootballTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :football_teams do |t|
      t.string :team_name

      t.timestamps
    end
  end
end
