class MembershipsController < ApplicationController
  # Olemassaoleva user id sessiosta - redirect jos ei ole + notice?
  # Param club id formista

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
    render :new
  end

  def create
    @membership = Membership.create(params.require(:membership).permit(:beer_club_id))
    @membership.user_id = current_user.id
    if(@membership.save)
      redirect_to(user_path(current_user.id))
    end

    # Redirect luonnin jälkeen noticen kanssa?
    # raise
  end
end