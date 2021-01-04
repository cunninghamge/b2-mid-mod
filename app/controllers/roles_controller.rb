class RolesController < ApplicationController
  def create
    actor = Actor.find_by_name(params[:role][:actor_name])
    role = Role.new(actor: actor, movie_id: params[:movie_id])
    if role.invalid?
      flash[:notice] = "Unable to add unknown actor"
    else
      role.save
    end
    redirect_to movie_path(params[:movie_id])
  end
end
