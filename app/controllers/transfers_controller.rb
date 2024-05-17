class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show ]
  before_action :set_pagante, only: %i[ create ]
  before_action :set_recebedor, only: %i[ create ]

  # GET /transfers
  def index
    @transfers = Transfer.all

    render json: @transfers
  end

  # GET /transfers/1
  def show
    render json: @transfer
  end

  # POST /transfers
  def create
    @transfer = Transfer.new(transfer_params)

    if @pagante.nil? || @recebedor.nil?
      render json: { error: 'Pagante ou Recebedor não encontrado' }, status: :unprocessable_entity
      return
    end

    if @pagante.user_type != "comum"
      render json: { error: 'Pagante não pode ser um lojista' }, status: :unprocessable_entity
      return
    end

    if @transfer.save
      if check_saldo
        render json: @transfer, status: :created, location: @transfer
      else
        render json: { error: 'Erro ao atualizar, saldo insuficiente' }, status: :unprocessable_entity
      end
    else
      render json: @transfer.errors, status: :unprocessable_entity
    end
  end

  private

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def set_recebedor
    @recebedor = User.find_by(id: params[:recebedor])
  end

  def set_pagante
    @pagante = User.find_by(id: params[:user_id])
  end

  def check_saldo
    if @pagante.saldo > 0 && @transfer.value <= @pagante.saldo
      update_saldo
    end
  end

  def update_saldo
    ActiveRecord::Base.transaction do
      @saldo_pagante = @pagante.saldo - @transfer.value
      @saldo_recebedor = @recebedor.saldo + @transfer.value

      @pagante.update_columns(saldo: @saldo_pagante)
      @recebedor.update_columns(saldo: @saldo_recebedor)
    end

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Erro ao atualizar saldo: #{e.message}"
  end

  def transfer_params
    params.require(:transfer).permit(:user_id, :recebedor, :value)
  end
end
