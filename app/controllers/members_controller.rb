class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { data: current_user, status: :ok }
  end
end