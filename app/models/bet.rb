# == Schema Information
#
# Table name: bets
#
#  id                   :integer          not null, primary key
#  favorite_or_underdog :string
#  likes_count          :integer
#  money_won_lost       :float
#  odds                 :float
#  opposing_team        :string
#  team_bet             :string
#  team_id_bet          :integer
#  wager                :float
#  win_loss             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  opposing_team_id     :integer
#  owner_id             :integer
#
class Bet < ApplicationRecord
end
