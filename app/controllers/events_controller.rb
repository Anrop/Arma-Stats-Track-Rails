class EventsController < ApplicationController
  before_action :set_mission
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    if params[:events] && params[:events].kind_of?(Array)
      @events = params[:events].map { |event| create_event(ActionController::Parameters.new({
        event: event
      })) }
      @events = @events.select { |event| event.save }

      render json: @events, status: :created
    else
      @event = create_event(params)

      if @event.save
        render json: @event, status: :created, location: [@mission, @event]
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params(params))
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    def set_mission
      @mission = Mission.find(params[:mission_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def create_event(params)
      event = Event.new(event_params(params))
      event.mission = @mission
      event
    end

    # Only allow a trusted parameter "white list" through.
    def event_params(params)
      params.require(:event).permit(:type, :data)
    end
end
