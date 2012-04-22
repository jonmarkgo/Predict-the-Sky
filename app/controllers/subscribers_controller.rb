class SubscribersController < ApplicationController
  # GET /subscribers
  # GET /subscribers.json
  def index
    @subscribers = Subscriber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscribers }
    end
  end

  # GET /subscribers/1
  # GET /subscribers/1.json
  def show
    @subscriber = Subscriber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscriber }
    end
  end

  # GET /subscribers/new
  # GET /subscribers/new.json
  def new
    @subscriber = Subscriber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscriber }
    end
  end

  # GET /subscribers/1/edit
  def edit
    @subscriber = Subscriber.find(params[:id])
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @subscriber.phonenumber = params[:subscriber][:phonenumber]
    @subscriber.phonenumber = @subscriber.phonenumber.gsub(/\D/, "")  
    address = params[:address] + ', ' + params[:city] + ', ' + params[:state] + ' ' + params[:zip]
    if (params[:address] != '')
      coords = Geocoder.coordinates(address)
      @subscriber.latitude = coords[0]
      @subscriber.longitude = coords[1]
    else
      @subscriber.latitude = params[:subscriber][:latitude]
      @subscriber.longitude = params[:subscriber][:latitude]
    end

    respond_to do |format|
      if @subscriber.save

        @client.account.sms.messages.create(
          :from => ENV['TWILIO_FROM_NUMBER'],
          :to => @subscriber.phonenumber,
          :body => 'Welcome to the Predict the Sky notification service! Txt STOP to unsubscribe.'
        )
        format.html { redirect_to :root, notice: 'Subscriber was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscribers/1
  # PUT /subscribers/1.json
  def update
    @subscriber = Subscriber.find(params[:id])

    respond_to do |format|
      if @subscriber.update_attributes(params[:subscriber])
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to subscribers_url }
      format.json { head :no_content }
    end
  end
end
