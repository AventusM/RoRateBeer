class SessionsController < ApplicationController
  def new
    # Login page

  end

  def create # Copypastetaan tämä muoto suoraan materiaalista selkeyden vuoksi
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä olemassa, ja että salasana on oikea
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to(user_path(user.id), notice: "Welcome back!")
    else
      redirect_to(signin_path, notice: "Username and/or password mismatch") # Mahdollista saada error tms. toimimaan täältä?
    end
  end

  def destroy
    # logout / signout
    session[:user_id] = nil
    redirect_to(breweries_path) # root olemassa? ei -> päivitä, breweries_path vissiin root?
  end
end