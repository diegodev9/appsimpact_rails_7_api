class ApiController < ApplicationController
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception, status: 'authorization_failed' }
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { message: error.message, status: 'invalid' }
  end
end