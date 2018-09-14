class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :destroy]
  layout 'mobile', only: [:show, :edit]

  # GET /leads
  # GET /leads.json
  def index
    @leads = Lead.all
    ab_finished(:test, reset: false)
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    @slot = Slot.all
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    @properties = Property.all
  end

  # GET /leads/1/edit
  def edit
  end

  def nyeleads
    @leads = Lead.all
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to edit_lead_path(@lead), notice: '👌 done' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: '👌 done' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: '👌 done' }
      format.json { head :no_content }
    end
  end

  def connect
    messenger_user_id = params['messenger user id']
    first_name = params['first name']
    last_name = params['last name']
    chatfuel_user_id = params['chatfuel user id']
    last_user_freeform_input = params['last user freeform input']
    profile_pic_url = params['profile pic url']
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
    params.fetch(:lead).permit(:user_id, :first_name, :last_name, :gender, :source, :locale, :profile_pic_url, :timezone, :messenger_user_id, :chatfuel_user_id, :ref, :country, :city, :state, :zip, :address, :latitude, :longitude, :map_url, :last_visited_block_name, :last_visited_block_id, :last_clicked_button_name, :last_user_freeform_input, :property, :timeanddate, :email, :slot_id, :time, :date, :secret, :property_id, :phone, :'first name', :'last name', :category, :property_type, :deadline, :purpose, :price_filter, :budget, :area, :pet, :cityarea, :rooms, :forsikring_valg)
    end

    def require_login
      unless current_user
        flash[:notice] = "You must log in."
        redirect_to new_user_session_path
      end
    end


end
