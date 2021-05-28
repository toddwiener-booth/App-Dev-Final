class FootballTeamsController < ApplicationController
  def index
    matching_football_teams = FootballTeam.all

    @list_of_football_teams = matching_football_teams.order({ :created_at => :desc })

    render({ :template => "football_teams/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_football_teams = FootballTeam.where({ :id => the_id })

    @the_football_team = matching_football_teams.at(0)

    render({ :template => "football_teams/show.html.erb" })
  end

  def create
    the_football_team = FootballTeam.new
    the_football_team.team_name = params.fetch("query_team_name")

    if the_football_team.valid?
      the_football_team.save
      redirect_to("/football_teams", { :notice => "Football team created successfully." })
    else
      redirect_to("/football_teams", { :notice => "Football team failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_football_team = FootballTeam.where({ :id => the_id }).at(0)

    the_football_team.team_name = params.fetch("query_team_name")

    if the_football_team.valid?
      the_football_team.save
      redirect_to("/football_teams/#{the_football_team.id}", { :notice => "Football team updated successfully."} )
    else
      redirect_to("/football_teams/#{the_football_team.id}", { :alert => "Football team failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_football_team = FootballTeam.where({ :id => the_id }).at(0)

    the_football_team.destroy

    redirect_to("/football_teams", { :notice => "Football team deleted successfully."} )
  end
end
