class Api::ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all
    if params[:name_search]
      @contacts = @contacts.where("first_name iLIKE ? OR last_name iLIKE ? OR middle_name iLIKe ?" , "%#{params[:name_search]}%", "%#{params[:name_search]}%", "%#{params[:name_search]}%")
    end
    if params[:email]
      @contacts = @contacts.where("email iLIKE ?", "#{params[:email]}")
    end
    render 'index.json.jb'
  end

  def show
    @contacts = Contact.all
    @contact_id = params["id"]
    @contact = Contact.find_by(id: @contact_id)
    render 'show.json.jb'
  end

  def create
    coordinates = Geocoder.coordinates(params[:address])
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      latitude: coordinates[0],
      longitude: coordinates[1]
    )
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages }, satus: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    
    if params[:address]
      coordinates = Geocoder.coordinates(params[:address])
      @contact.latitude = coordinates[0]
      @contact.longitude = coordinates[1]
    end

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.bio = params[:bio] || @contact.bio
    @contact.latitude = params[:latitude] || @contact.latitude
    @contact.longitude = params[:longitude] || @contact.longitude
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages }, satus: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "Contact has been deleted!"}
  end

end
