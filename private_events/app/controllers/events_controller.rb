class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new, :show]

  def new
  	@event = current_user.events.build
  end

  def create
	 @event = current_user.events.build(event_params)
  	if @event.save
      @event.attendees << current_user
  		flash[:success] = "Event created successfully!"
  		redirect_to @event
  	else
  		flash.now[:danger] = "Error creating event"
  		render 'new'
  	end
  end

  def going 
    @event = Event.find(params[:id])
    if !@event.attendees.include?(current_user)
      @event.attendees << current_user
      flash[:success] = "You're now in the list of the attendees"
    end
    redirect_to @event
  end

  def show
  	@event = Event.find(params[:id])
  end

  def index
  	@events = Event.all
    @upcoming_events = Event.upcoming
    @previous_events = Event.past
  end

  private

  	def event_params
  		params.require(:event).permit(:title, :description, :location, :date)
  	end
end
