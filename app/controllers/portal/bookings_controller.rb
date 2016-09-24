module Portal
  class BookingsController < ApplicationController
    load_and_authorize_resource
    before_action :set_booking, only: [:show, :edit, :update, :destroy]

    # GET /bookings
    # GET /bookings.json
    def index
      @bookings = Booking.all
    end

    # GET /bookings/1
    # GET /bookings/1.json
    def show
    end

    # GET /bookings/new
    def new
      @booking = Booking.new
    end

    # GET /bookings/1/edit
    def edit
    end

    def cancel
      @booking = Booking.find(params[:id])
      
      if @booking.status == "Booked"
        @conference_room_id = @booking.conference_room_id
        @conference_rooms = Booking.where(conference_room_id: @conference_room_id, status: "Pending")
        if @conference_rooms
          @new_conference_room = @conference_rooms.first
          @date = @conference_rooms.first.created_at
          @conference_rooms.each do |conference_room|
            @new_date = conference_room.created_at
            if @new_date < @date
              @date = @new_date
              @new_conference_room = conference_room
            end
          end

          @new_conference_room.update(:status => "Booked")
          @user = User.find(@new_conference_room.user_id)
          ExampleMailer.booking_email(@user, @new_conference_room).deliver
        end
      end

      respond_to do |format|     
        if @booking.update(:status => "Cancelled")
          @user = User.find(@booking.user_id)
          ExampleMailer.cancel_email(@user, @booking).deliver
          format.html { redirect_to portal_bookings_url(@booking), notice: 'booking room was successfully Cancelled.' }
        end
      end      
    end

    # POST /bookings
    # POST /bookings.json
    def create
      @status = "Booked"
      @status_notice = 'booking was successfully created.'
      @bookings = Booking.where(:conference_room_id => params[:conference_room_id])
      @bookings.each do |booking| 
        if (booking.start_time..booking.end_time).cover?(params[:booking][:start_time]) || (booking.start_time..booking.end_time).cover?(params[:booking][:end_time]) || (params[:booking][:start_time]..params[:booking][:end_time]).cover?(booking.start_time) || (params[:booking][:start_time]..params[:booking][:end_time]).cover?(booking.end_time)
          @status = "Pending"
          @status_notice = "Sorry, Your requested slot is already Booked. so your requestis Pending state."
        end
      end

      respond_to do |format|
        if params[:booking][:start_time].to_date.wday == 0 || params[:booking][:end_time].to_date.wday == 0 || params[:booking][:start_time].to_date.wday == 6 || params[:booking][:end_time].to_date.wday == 6
          format.html { redirect_to portal_conference_room_bookings_url, alert: 'Sorry!, Bookings are not allowed on Weekend.' }
        else                    
          if Time.now < params[:booking][:start_time] && params[:booking][:start_time] < params[:booking][:end_time]
            @booking = Booking.new(:conference_room_id => params[:conference_room_id], :status => @status, :user_id => current_user.id, :start_time => params[:booking][:start_time], :end_time => params[:booking][:end_time], :created_at => Time.now)
            if @booking.save!
              
              @user = User.find(@booking.user_id)
              if @status == "Booked"
                ExampleMailer.booking_email(@user, @booking).deliver
              elsif @status == "Pending"
                ExampleMailer.pending_email(@user, @booking).deliver
              end

              format.html { redirect_to portal_conference_room_bookings_url, notice: @status_notice }
              format.json { render :show, status: :created, location: @booking }
            else
              format.html { render :new }
              format.json { render json: @booking.errors, status: :unprocessable_entity }
            end
          else
            format.html { redirect_to portal_conference_room_bookings_url, alert: 'Please Book Conference Room for future date.' }
          end        
        end
      end
    end

    # PATCH/PUT /bookings/1
    # PATCH/PUT /bookings/1.json
    def update
      respond_to do |format|
        if @booking.update(booking_params)
          format.html { redirect_to portal_booking_url(@booking), notice: 'booking room was successfully updated.' }
          format.json { render :show, status: :ok, location: @booking }
        else
          format.html { render :edit }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /bookings/1
    # DELETE /bookings/1.json
    def destroy
      @booking.destroy
      respond_to do |format|
        format.html { redirect_to portal_bookings_url, notice: 'booking was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_booking
        @booking = Booking.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def booking_params
        params.require(:booking).permit(:conference_room_id, :status, :start_time, :end_time)
      end
  end
end