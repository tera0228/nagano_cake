class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "編集に成功しました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "編集に失敗しました"
      render :edit
    end
  end

  # ストロングパラメータ
  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
