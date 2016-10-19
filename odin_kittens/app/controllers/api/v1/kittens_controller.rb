module Api
	module V1 
		class KittensController < ApplicationController 
					
			def index 
				respond_to do |format|
					format.json { render json: Kitten.all }
					format.xml 	{ render xml: Kitten.all }
				end
			end

			def show 
				respond_to do |format|
					format.json { render json: Kitten.find(params[:id]) }
					format.xml 	{ render xml: Kitten.find(params[:id]) }
				end
			end
		end
	end
end
