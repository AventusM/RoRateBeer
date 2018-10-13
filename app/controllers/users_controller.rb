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
    return redirect_to(users_url, notice: 'You have no permission to edit this user.') if not @user == current_user
    respond_to do |format|
      if user_params[:username].nil? and @user.update(user_params) # Ehto käyttäjätietojen muuttamiselle on se, että :username - field on null (eli tätä haaraa ei suoriteta, jos POST-pyynnön mukana on kyseiseen kenttään liitettyä dataa)
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
    return redirect_to(users_url, notice: 'You have no permission to destroy this user.') if not @user == current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
      reset_session # Kokeillaan tyhjentää olemassaoleva sessio? TOIMII!!
    end
  end

  def toggle_banned
    if (current_user.admin)
      user = User.find(params[:user_id])
      user.update_attribute :banned, (not user.banned)
      redirect_to(user)
    else
      redirect_to(breweries_path) # Estetään turha pelleily(?)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
