class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin_id = current_user.id
    if @group.save
      flash[:notice] = "Group successfully created!"
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def index
    @user = current_user
    @book = @user.books.new
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @user = current_user
    @book = @user.books.new
  end

  def edit
    @group = Group.find(params[:id])

  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end



  private

  def group_params
    params.require(:group).permit(:name, :body, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.admin_id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
