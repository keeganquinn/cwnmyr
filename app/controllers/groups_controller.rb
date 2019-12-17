# frozen_string_literal: true

# This controller facilitates interaction with Groups.
class GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  after_action :verify_authorized

  # Show action.
  def show
    @group = authorize Group.find(params[:id])
  end
end
