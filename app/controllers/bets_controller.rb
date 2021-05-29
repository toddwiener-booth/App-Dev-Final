class BetsController < ApplicationController
  def homepage

    the_id = session[:user_id]
    users_bets = Bet.where({ :owner_id => the_id })
    @balance = 0
    @total_wagers = 0

    users_bets.each do |bet|
      @balance = @balance + bet.money_won_lost
      @total_wagers = @total_wagers + bet.wager
    end

    @money_won_or_lost = @total_wagers - @balance - @total_wagers

    render({ :template => "bets/homepage.html.erb"})
  end

  def leaderboard

    all_users = User.all

    all_users.each do |user|
        
      the_id = user.id
      users_bets = Bet.where({ :owner_id => the_id })
      @balance = 0
      @total_wagers = 0

      users_bets.each do |bet|
        @balance = @balance + bet.money_won_lost
        @total_wagers = @total_wagers + bet.wager
      end

      @money_won_or_lost = @total_wagers - @balance - @total_wagers

    end 

    render({ :template => "bets/leaderboard.html.erb"})
  end

  
  def index
    #matching_bets = Bet.all
    the_id = session[:user_id]
    matching_bets = Bet.where({ :owner_id => the_id })

    @list_of_bets = matching_bets.order({ :created_at => :desc })

    all_teams = FootballTeam.all

    @list_of_teams = all_teams.order({ :team_name => :asc })

    @user = User.where({ :id => session[:user_id] }).first

    render({ :template => "bets/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bets = Bet.where({ :id => the_id })

    @the_bet = matching_bets.at(0)

    render({ :template => "bets/show.html.erb" })
  end

  def create
    the_bet = Bet.new
    the_bet.team_bet = params.fetch("query_team_bet")
    the_bet.favorite_or_underdog = params.fetch("query_favorite_or_underdog")
    the_bet.opposing_team = params.fetch("query_opposing_team")
    the_bet.win_loss = params.fetch("query_win_loss")
    the_bet.odds = params.fetch("query_odds")
    the_bet.wager = params.fetch("query_wager")
    the_bet.owner_id = session[:user_id]

    team = FootballTeam.where( :team_name => the_bet.team_bet).at(0)
    the_bet.team_id_bet = team.id

    oppTeam = FootballTeam.where( :team_name => the_bet.opposing_team).at(0)
    the_bet.opposing_team_id = oppTeam.id

    #the_bet.team_id_bet = params.fetch("query_team_id_bet")
    #the_bet.opposing_team_id = params.fetch("query_opposing_team_id")
    the_bet.likes_count = 0

    if the_bet.win_loss == "Loss"
      the_bet.money_won_lost = -the_bet.wager
    end
    if the_bet.win_loss == "Pending"
      the_bet.money_won_lost = 0
    end
    if the_bet.win_loss == "Win"
      if the_bet.favorite_or_underdog == "Underdog"
        the_bet.money_won_lost = (the_bet.wager * (the_bet.odds / 100)) + the_bet.wager
      else
        the_bet.money_won_lost = ((100 / the_bet.odds) * the_bet.wager) + the_bet.wager
      end
    end


    #the_bet.money_won_lost = 0 #params.fetch("query_money_won_lost")

    if the_bet.valid?
      the_bet.save

      #the_user = User.where({ :id => session[:user_id]}).at(0)
      #the_user.total_balance = the_user.total_balance + the_bet.money_won_lost
            
      redirect_to("/bets", { :notice => "Bet created successfully." })
    else
      redirect_to("/bets", { :notice => "Bet failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)

    the_bet.team_bet = params.fetch("query_team_bet")
    the_bet.favorite_or_underdog = params.fetch("query_favorite_or_underdog")
    the_bet.opposing_team = params.fetch("query_opposing_team")
    the_bet.win_loss = params.fetch("query_win_loss")
    the_bet.odds = params.fetch("query_odds")
    the_bet.wager = params.fetch("query_wager")
    the_bet.owner_id = params.fetch("query_owner_id")
    the_bet.money_won_lost = params.fetch("query_money_won_lost")
    the_bet.team_id_bet = params.fetch("query_team_id_bet")
    the_bet.opposing_team_id = params.fetch("query_opposing_team_id")
    the_bet.likes_count = params.fetch("query_likes_count")

    if the_bet.valid?
      the_bet.save
      redirect_to("/bets/#{the_bet.id}", { :notice => "Bet updated successfully."} )
    else
      redirect_to("/bets/#{the_bet.id}", { :alert => "Bet failed to update successfully." })
    end
  end

  def update_outcome
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)

    the_bet.win_loss = params.fetch("outcome")

    if the_bet.win_loss == "Loss"
      the_bet.money_won_lost = -the_bet.wager
    end
    if the_bet.win_loss == "Pending"
      the_bet.money_won_lost = 0
    end
    if the_bet.win_loss == "Win"
      if the_bet.favorite_or_underdog == "Underdog"
        the_bet.money_won_lost = (the_bet.wager * (the_bet.odds / 100)) + the_bet.wager
      else
        the_bet.money_won_lost = ((100 / the_bet.odds) * the_bet.wager) + the_bet.wager
      end
    end

    the_bet.save
    redirect_to("/bets/", { :notice => "Bet updated successfully."} )

  end

  def destroy
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)

    the_bet.destroy

    redirect_to("/bets", { :notice => "Bet deleted successfully."} )
  end
end
