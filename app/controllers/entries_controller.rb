class EntriesController < ApplicationController

  def new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/places"
  end

end
