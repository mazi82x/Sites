class RestaurantsController < ApplicationController

	http_basic_authenticate_with name: "mazi", password: "admin", except: [:index, :show]
	http_basic_authenticate_with name: "mazi", password: "admin", only: :destroy
	
	def new
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.new
	end

	def show #show one item
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.find(params[:id])
	end
	
	def edit
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.find(params[:id])
	end
	
	def index #show all items
		@city = City.find(params[:city_id])		
		@restaurants = Restaurant.all

	end
	
	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		redirect_to restaurants_path
	end
	
	def create
		@city = City.find(params[:city_id])
		@restaurant = @city.restaurants.create(restaurant_params)
		if @restaurant.save #return bool 
			redirect_to city_restaurants_path(@city)
		else #validation model fail
			render 'new' #render używane do tego samego formularza
		end
	end
	
	def update #already exiting record update
		#render plain: params[:article].inspect
		@city = City.find(params[:city_id])
		@restaurant = Restaurant.find(params[:id])
 
		if @restaurant.update(restaurant_params)
			redirect_to city_restaurants_path(@city)
		else
			render 'edit'
		end
	end
	
	private def restaurant_params #Use strong parameters mechanism
		params.require(:restaurant).permit(:name, :address, :remarks	, :cuisine, :photo)
	end
end
