class PropertiesController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
    @properties.each do |property|
      @properties_to_render = {
        :messages => [
          {
            :type => "template",
            :payload => {
              :template_type => "generic",
              :image_aspect_ratio => "square",
              :elements => [
                {
                  :title => "#{property.address}",
                  :image_url => "https://thumb7.shutterstock.com/display_pic_with_logo/109564/436440067/stock-vector-human-resources-management-select-employee-recruitment-concept-of-human-resources-management-cv-436440067.jpg",
                  :subtitle => "$ #{property.price}",
                  :buttons => [
                    {
                      :type => "web_url",
                      :url => "http://chatestate.herokuapp.com/properties/#{property.id}",
                      :title => "Click here."
                    } 
                  ]
                }
              ]
            }
          }
        ]
      }
    end    
    render :json => @properties_to_render
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property_images = @property.property_images.all
  end

  # GET /properties/new
  def new
    @property = Property.new
    @property_image = @property.property_images.build
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:user_id, :image, :address, :description, :price, :property_image_id, property_images_attributes: [:id, :image, :property_id, :destroy])
    end

    def require_login
      unless current_user
        flash[:notice] = "You must log in."
        redirect_to new_user_session_path
      end
    end

end
