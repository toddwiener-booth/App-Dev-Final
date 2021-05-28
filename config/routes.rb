Rails.application.routes.draw do


  get("/", { :controller => "bets", :action => "homepage"})


  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Bet resource:

  # CREATE
  post("/insert_bet", { :controller => "bets", :action => "create" })
          
  # READ
  get("/bets", { :controller => "bets", :action => "index" })
  
  get("/bets/:path_id", { :controller => "bets", :action => "show" })
  
  # UPDATE
  
  post("/modify_bet/:path_id", { :controller => "bets", :action => "update" })
  
  # DELETE
  get("/delete_bet/:path_id", { :controller => "bets", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the Football team resource:

  # CREATE
  post("/insert_football_team", { :controller => "football_teams", :action => "create" })
          
  # READ
  get("/football_teams", { :controller => "football_teams", :action => "index" })
  
  get("/football_teams/:path_id", { :controller => "football_teams", :action => "show" })
  
  # UPDATE
  
  post("/modify_football_team/:path_id", { :controller => "football_teams", :action => "update" })
  
  # DELETE
  get("/delete_football_team/:path_id", { :controller => "football_teams", :action => "destroy" })

  #------------------------------

end
