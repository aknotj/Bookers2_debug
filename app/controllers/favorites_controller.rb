class FavoritesController < ApplicationController
  before_action :book_params

  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    render 'create'
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    render 'destroy'
  end




  private

  def book_params
    @book = Book.find(params[:book_id])
  end

end
