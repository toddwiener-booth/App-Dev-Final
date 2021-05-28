# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  bets_count      :integer
#  default_bet     :float
#  email           :string
#  favorite_team   :string
#  password_digest :string
#  total_balance   :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
end
