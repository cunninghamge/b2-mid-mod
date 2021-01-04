class RolesController < ApplicationController
  def create
    actor = Actor.find_by_name(params[:role][:actor_name])
    Role.create!(actor: actor, movie_id: params[:movie_id])
    redirect_to movie_path(params[:movie_id])
  end
end
