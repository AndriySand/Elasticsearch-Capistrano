class RecordsController < ApplicationController
  require 'csv'
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query]
      @records = RecordsIndex.query(query_string: {query: params[:query] } ).load
    else
      @records = Record.paginate(page: params[:page], per_page: 5)
      render json: @records if request.format == 'json'
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_data
    number_of_records = 0
    CSV.foreach(params[:file].path, headers: true) do |row|
      Record.create! row.to_hash
      number_of_records += 1
    end
    UserMailer.welcome_email('admin@inbox.ru', number_of_records).deliver_now
    redirect_to records_url
  end

  def select_records
    @records = Record.where('klass = ?', params[:klass])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:klass, :value)
    end
end
