class EventsController < ApplicationController
  def new
  	@event = current_user.events.build
  end

  def create
  	@event = current_user.events.build(event_params)
  	if @event.save
  		flash[:success] = "Event created successfully!"
  		redirect_to @event
  	else
  		flash.now[:danger] = "Error creating event"
  		render 'new'
  	end
  end

  def show
  	@event = Event.find(params[:id])
  end

  def index
  	@events = Event.all
  end

  private

  	def event_params
  		params.require(:event).permit(:title, :description, :location, :date)
  	end
end
