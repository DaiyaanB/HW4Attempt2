class EntriesController < ApplicationController
  def index
    @place = Place.find_by(id: params[:place_id])
    if @place
      @entries = @place.entries.where(user_id: session["user_id"])
    else
      flash[:alert] = "Place not found"
      redirect_to "/places"
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entry = Entry.new
      @entry.title = params["title"]
      @entry.description = params["description"]
      @entry.occurred_on = params["occurred_on"]
      @entry.place_id = params["place_id"]
      @entry.user_id = params["author_id"] # This is indirectly session["user_id"] to match the logged-in user
      @entry.uploaded_image.attach(params["uploaded_image"])
  
      if @entry.save
        @entry.uploaded_image.attach(params[:entry][:uploaded_image]) if params[:entry] && params[:entry][:uploaded_image].present?
        redirect_to "/places/#{@entry.place_id}" and return
      else
        render :new and return
      end
    else
      flash["notice"] = "Login first."
      redirect_to "/login" and return
    end
  end
  

  # removes security restrictions for API calls
  before_action :allow_cors
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end  

  #Strong Parameters
  private
  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id, :uploaded_image)
  end
  
end

