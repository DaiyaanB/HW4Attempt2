Rails.application.routes.draw do
  #The Root Route
  get("/", { :controller => "sessions", :action => "new" })
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"

  # Login/logout
  get("/login", { :controller => "sessions", :action => "new" })
  get("/logout", { :controller => "sessions", :action => "destroy" })

end
