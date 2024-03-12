class EntriesController < ApplicationController
  def index
    @posts = Post.all
    # alternative responses to requests other than HTML
    respond_to do |format|
      format.html # implicitly renders posts/index.html.erb
      format.json do
        render :json => @posts
      end
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = params["author_id"]
      if @entry.save
        redirect_to "/places/#{@entry["place_id"]}" and return
      else
        # handle save failure, e.g., by rendering the 'new' template again with error messages
        render :new and return
      end
    else
      flash["notice"] = "Login first."
      redirect_to "/login" and return # Assuming you have a login path, adjust as needed
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
end

