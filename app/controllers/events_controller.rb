class EventsController < ApplicationController
  def index
    render json: Event.all, status: :ok
  end

  def show
    render json: Event.find(params[:id]), status: :ok
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event, status: :ok
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: event
  end

  private
  def event_params
    params.require(:event).permit(:name, :start, :end)
  end
end
