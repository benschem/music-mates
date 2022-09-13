class GroupsController < ApplicationController

  def create
  end

  def new
  end

  def show
    @group = Group.find(params[:id])
  end
end
