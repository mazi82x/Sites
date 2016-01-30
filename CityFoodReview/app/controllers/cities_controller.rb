class CitiesController < ApplicationController

	http_basic_authenticate_with name: "mazi", password: "admin", except: [:index, :show]
	http_basic_authenticate_with name: "mazi", password: "admin", only: :destroy
	
	def new
	  @city = City.new
	end

	def show #show one item
		@city = City.find(params[:id])
	end
	
	def edit
		@city = City.find(params[:id])
	end
	
	def index #show all items
		@cities = City.all.order("name")
	end
	
	def destroy
		@city = City.find(params[:id])
		@city.destroy
		redirect_to city_path
	end
	
	def create
		@city = City.new(city_params)
		if @city.save #return bool 
			redirect_to cities_path
		else #validation model fail
			render 'new' #render używane do tego samego formularza
		end
	end
	
	def update #already exiting record update
		#render plain: params[:article].inspect
		@city = City.find(params[:id])
 
		if @city.update(city_params)
			redirect_to cities_path
		else
			render 'edit'
		end
	end
	
	private def city_params #Use strong parameters mechanism
		params.require(:city).permit(:name, :photo)
	end
end
