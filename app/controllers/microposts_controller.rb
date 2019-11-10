class MicropostsController < ApplicationController
def create
  @micropost = current_user.microposts.build(micropost_params)
  if @micropost.save
    flash[:success] = "Micropost Created!"
    redirect_to root_url
  else
    @microposts = current_user.microposts
    render "users/home_feeds"

  end
end

private
  def micropost_params
    params.require(:micropost).permit(:content)
  end


end
