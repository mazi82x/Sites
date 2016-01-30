class VotesController < ApplicationController

	http_basic_authenticate_with name: "mazi", password: "admin", except: [:index, :show]
	http_basic_authenticate_with name: "mazi", password: "admin", only: :destroy
	
	def new
	  @city = City.find(params[:city_id])
	  @restaurant = Restaurant.find(params[:restaurant_id])
	  @vote = Vote.new
	end

	def show #show one item
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.find(params[:restaurant_id])
		@vote = Vote.find(params[:id])
	end
	
	def edit
		@vote = Vote.find(params[:id])
	end
	
	def index #show all items
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.find(params[:restaurant_id])
		@votes = Vote.all
	end
	
	def destroy
		@vote = Vote.find(params[:id])
		@vote.destroy
		redirect_to vote_path
	end
	
	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@vote = @restaurant.votes.create(vote_params)
		if @vote.save #return bool 
			redirect_to city_restaurant_votes_path
		else #validation model fail
			render 'new' #render używane do tego samego formularza
		end
	end
	
	def update #already exiting record update
		#render plain: params[:article].inspect
		@vote = Vote.find(params[:id])
 
		if @vote.update(vote_params)
			redirect_to votes_path
		else
			render 'edit'
		end
	end
	
	private def vote_params #Use strong parameters mechanism
		params.require(:vote).permit(:voter, :vote, :comment)
	end
end

