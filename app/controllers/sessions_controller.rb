class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash["info"] = "Succesfully logged in."
      # flash ={"#" => "info", "#" => "Succesfully logged in"}
      # flash[type] = msg
      redirect_to root_url
    else
      render "new"
      flash.now[:danger] ="Invalid Credentions"
    end
  end

  def destroy
    log_out
    flash[:info] = "Logout yes!"
    redirect_to root_url
  end
end
