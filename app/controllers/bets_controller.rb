class BetsController < ApplicationController
  def homepage

    the_id = session[:user_id]
    @the_user = User.where({ :id => session[:user_id] }).at(0)
    users_bets = Bet.where({ :owner_id => the_id })

    @balance = 0
    @total_wagers = 0

    users_bets.each do |bet|
      
      @balance = @balance + bet.money_won_lost
      @total_wagers = @total_wagers + bet.wager
    end
    if @balance > 0 
      @money_won_or_lost = @balance - @total_wagers
    else 
       @money_won_or_lost = @balance
    end


    render({ :template => "bets/homepage.html.erb"})
  end

  def leaderboard

    #@all_users = User.all.order({ :money_won_lost => desc})

    @all_users = User.all.sort_by(&:total_balance).reverse()

    @balance = 0
    @total_wagers = 0
    @pending_wagers = 0
    #@loss_counter = 0
    #@win_counter = 0
    @roi = 0

    @best_bet_odds_favorite = 1000000
    @best_bet_odds_underdog = 0
    @best_bet_sign = "+"

     @all_users.each do |user|
        users_bets = Bet.where({ :owner_id => user.id })
      if users_bets != nil
        users_bets.each do |bet|
          if bet.win_loss == "Win"
            if bet.favorite_or_underdog == "Favorite" && bet.odds < @best_bet_odds_favorite
              @best_bet_odds_favorite = bet.odds
              @best_bet_favorite = bet
            elsif bet.favorite_or_underdog == "Underdog" && bet.odds > @best_bet_odds_underdog
              @best_bet_odds_underdog = bet.odds
              @best_bet_underdog = bet
            end
          end
        end
        end
      end

      if @best_bet_underdog == 0
        @best_bet_underdog = @best_bet_favorite
        @best_bet_sign = "-"
      end
      
      @best_bet_user = User.where({ :id => @best_bet_underdog.owner_id }).at(0)
    

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

    all_teams = FootballTeam.all

    @list_of_teams = all_teams.order({ :team_name => :asc })

    @user = User.where({ :id => session[:user_id] }).first

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
    outcome = params.fetch("query_win_loss")

    team = FootballTeam.where( :team_name => the_bet.team_bet).at(0)
    the_bet.team_id_bet = team.id

    oppTeam = FootballTeam.where( :team_name => the_bet.opposing_team).at(0)
    the_bet.opposing_team_id = oppTeam.id

    #the_bet.team_id_bet = params.fetch("query_team_id_bet")
    #the_bet.opposing_team_id = params.fetch("query_opposing_team_id")
    the_bet.likes_count = 0

    if outcome == "Loss"
      the_bet.money_won_lost = -the_bet.wager
    elsif outcome == "Pending"
      the_bet.money_won_lost = 0
    else
      #if the_bet.win_loss == "Win"
        if the_bet.favorite_or_underdog == "Underdog"
          the_bet.money_won_lost = (the_bet.wager * (the_bet.odds / 100)) + the_bet.wager
        else
          the_bet.money_won_lost = ((100 / the_bet.odds) * the_bet.wager) + the_bet.wager
        end
    end


    #the_bet.money_won_lost = 0 #params.fetch("query_money_won_lost")

    if the_bet.valid?


      the_user = User.where({ :id => session[:user_id]}).at(0)
      the_user.bets_count = the_user.bets_count + 1
      if outcome == "Win"
        the_user.total_balance = the_user.total_balance + the_bet.money_won_lost - the_bet.wager
      else
        the_user.total_balance = the_user.total_balance + the_bet.money_won_lost
      end

      the_user.save
      the_bet.save
            
      redirect_to("/bets", { :notice => "Bet created successfully." + "w/l: " + outcome + "balance: " + the_user.total_balance.to_s + "th_bet.money_won_lost: " +  the_bet.money_won_lost.to_s})
    else
      redirect_to("/bets", { :notice => "Bet failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)

    old_money_won_lost = the_bet.money_won_lost

    the_bet.team_bet = params.fetch("query_team_bet")
    the_bet.favorite_or_underdog = params.fetch("query_favorite_or_underdog")
    the_bet.opposing_team = params.fetch("query_opposing_team")
    the_bet.win_loss = params.fetch("query_win_loss")
    the_bet.odds = params.fetch("query_odds")
    the_bet.wager = params.fetch("query_wager")
    the_bet.owner_id = session[:user_id]
    outcome = params.fetch("query_win_loss")

    team = FootballTeam.where( :team_name => the_bet.team_bet).at(0)
    the_bet.team_id_bet = team.id

    oppTeam = FootballTeam.where( :team_name => the_bet.opposing_team).at(0)
    the_bet.opposing_team_id = oppTeam.id

    if outcome == "Loss"
      the_bet.money_won_lost = -the_bet.wager
    elsif outcome == "Pending"
      the_bet.money_won_lost = 0
    else
      #if the_bet.win_loss == "Win"
        if the_bet.favorite_or_underdog == "Underdog"
          the_bet.money_won_lost = (the_bet.wager * (the_bet.odds / 100)) + the_bet.wager
        else
          the_bet.money_won_lost = ((100 / the_bet.odds) * the_bet.wager) + the_bet.wager
        end
    end

    if the_bet.valid?
      the_bet.save

      the_user = User.where({ :id => session[:user_id]}).at(0)
      #the_user.bets_count = the_user.bets_count + 1
      if the_bet.win_loss == "Win"
        the_user.total_balance = the_user.total_balance - old_money_won_lost + the_bet.money_won_lost - the_bet.wager
      else
        the_user.total_balance = the_user.total_balance - old_money_won_lost + the_bet.money_won_lost
      end
      the_user.save

      redirect_to("/bets/#{the_bet.id}", { :notice => "Bet updated successfully."} )
    else
      redirect_to("/bets/#{the_bet.id}", { :alert => "Bet failed to update successfully." })
    end
  end

  def update_outcome
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)
    old_money_won_lost = the_bet.money_won_lost

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

    the_user = User.where({ :id => session[:user_id]}).at(0)
      if the_bet.win_loss == "Win"
        the_user.total_balance = the_user.total_balance - old_money_won_lost + the_bet.money_won_lost - the_bet.wager
      else
        the_user.total_balance = the_user.total_balance - old_money_won_lost + the_bet.money_won_lost
      end
    the_user.save


    redirect_to("/bets/", { :notice => "Bet updated successfully."} )

  end

  def destroy
    the_id = params.fetch("path_id")
    the_bet = Bet.where({ :id => the_id }).at(0)
    old_money_won_lost = the_bet.money_won_lost

    the_bet.destroy

    the_user = User.where({ :id => session[:user_id]}).at(0)
    the_user.bets_count = the_user.bets_count - 1
    the_user.total_balance = the_user.total_balance - old_money_won_lost
    the_user.save

    redirect_to("/bets", { :notice => "Bet deleted successfully."} )
  end
end
