class PostsController < ApplicationController
  require 'mechanize'

  def index
    @user = User.all
    @elements = Fish.all

  end

end