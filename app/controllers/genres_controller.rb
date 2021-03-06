class GenresController < ApplicationController
  
  load_and_authorize_resource
  # before_action :authenticate_user!
  
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.order('genres.live_music, genres.name')
  end


  def new
    @genre = Genre.new
  end

  def create
    Genre.create(genre_params) 
    redirect_to(genres_path)
  end

  def show
  end

  def destroy
    @genre.destroy
    redirect_to(genres_path)
  end

  def edit
  end

  def update
    @genre.update(genre_params) 
    redirect_to(genres_path)
  end


  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :live_music)
  end


end