# frozen_string_literal: true

# This controller facilitates interaction with Contacts.
class ContactsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def show
    @contact = authorize Contact.find(params[:id])
  end

  def new
    @contact = authorize Contact.new(user_id: current_user.id)
  end

  def create
    @contact = authorize Contact.new(permitted_attributes(Contact))
    save_and_respond @contact, :created, :create_success
  end

  def edit
    @contact = authorize Contact.find(params[:id])
  end

  def update
    @contact = authorize Contact.find(params[:id])
    @contact.assign_attributes permitted_attributes(@contact)
    save_and_respond @contact, :ok, :update_success
  end

  def destroy
    @contact = authorize Contact.find(params[:id])
    destroy_and_respond @contact, browse_path
  end
end
