# == Schema Information
#
# Table name: football_teams
#
#  id         :integer          not null, primary key
#  team_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FootballTeam < ApplicationRecord
end
