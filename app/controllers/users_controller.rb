class UsersController < ApplicationController
  def index
    @list_of_users = User.all.order(username: :asc)
    render(template: "users_html/index")
  end

  def show
    @username = params.fetch("username")
    @the_user = User.where(username: @username).first

    if @the_user == nil
      redirect_to("/404")
    else
      render(template: "users_html/show")
    end
  end

  def create
    my_input_username = params.fetch("input_username")
    new_user = User.new
    new_user.username = my_input_username
    new_user.save
    redirect_to("/users/" + my_input_username)
  end

  def update
    user_id = params.fetch("user_id")
    my_input_username = params.fetch("input_username")
    the_user = User.where(id: user_id).first
    the_user.username = my_input_username
    the_user.save
    redirect_to("/users/" + my_input_username)
  end

  def comments
    Comment.where({:author_id => @the_user.id})
  end

  def photos
    Photo.where({:owner_id => @the_user.id})
  end

  def likes
    Like.where({:fan_id => @the_user.id})
  end

  def follow_requests
    Follow_Request.where({:sender_id => @the_user.id})
  end

  def follow_receipts
    Follow_Request.where({:recipient_id => @the_user.id})
  end
end
