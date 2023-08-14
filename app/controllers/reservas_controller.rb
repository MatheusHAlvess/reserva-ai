class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[ show edit update destroy ]

  # GET /reservas or /reservas.json
  def index
    @reservas = Reserva.all
  end

  # GET /reservas/1 or /reservas/1.json
  def show
  end

  # GET /reservas/new
  def new
    @reserva = Reserva.new
  end

  # GET /reservas/1/edit
  def edit
  end

  # GET /reservas/buscar
  def buscar
  end


  def resultado
    cpf = params[:cpf]
    @reservas = Reserva.buscar_por_cpf(cpf)

    if params[:data_inicio].present? && params[:data_fim].present?
      data_inicio = Date.parse(params[:data_inicio])
      data_fim = Date.parse(params[:data_fim])
      @reservas = @reservas.select do |reserva|
        reserva.entrada >= data_inicio && reserva.saida <= data_fim
      end
    end
    @data_inicio_filtro = params[:data_inicio]
    @data_fim_filtro = params[:data_fim]
    @cpf = cpf
  end

  # POST /reservas or /reservas.json
  def create
    @reserva = Reserva.new(reserva_params)

    respond_to do |format|
      if @reserva.save
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva was successfully created." }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservas/1 or /reservas/1.json
  def update
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva was successfully updated." }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservas/1 or /reservas/1.json
  def destroy
    @reserva.destroy

    respond_to do |format|
      format.html { redirect_to reservas_url, notice: "Reserva was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:cliente_id, :quarto_id, :entrada, :saida)
    end
end
