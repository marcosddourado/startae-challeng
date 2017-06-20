require 'twitter'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    set_up_twitter

    tweets = @client.user_timeline(@user.twitter_id, count: 5)
    @user.last_tweet = tweets.first.full_text

    last_tweets = ''
    tweets.each do |tweet|
      last_tweets += tweet.full_text + '\n'
    end

    @user.five_last_tweets = last_tweets
  end

  def set_up_twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "DFnbUzF6jE0HPWaouP7ToimYj"
      config.consumer_secret = "ytpWo9iXUfk6XfTb7ekWmoKaPY4RQOvCE6gZLctZsy8Tz8C0pL"
      config.access_token = "4188181033-5G66bV66skfnZxCpBRWDrZGPCuHITwzkVp9XeFl"
      config.access_token_secret = "XAEYKzGBGC50yqjUfdRoK5rvBLIKhzRVibd0IuiGGcqOq"
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :job_tittle, :last_tweet, :twitter_id)
    end
end
