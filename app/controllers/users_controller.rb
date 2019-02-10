# frozen_string_literal: true

# This controller allows viewing of User records.
class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = authorize User.find(params[:id])
  end
end
