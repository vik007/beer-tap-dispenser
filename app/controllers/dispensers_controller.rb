# frozen_string_literal: true

# Provides endpoints for CRUD operations on dispensers
class DispensersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_dispenser, only: %i[edit update destroy show]

  def index
    @dispensers = Dispenser.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
  end

  def show
    @dispense_events = @dispenser.dispense_events.paginate(page: params[:page], per_page: 30).order(created_at: :desc)
  end

  def new
    @dispenser = Dispenser.new
    respond_to(&:turbo_stream)
  end

  def create
    @dispenser = Dispenser.new(dispenser_params)
    respond_to do |format|
      if @dispenser.save
        format.html { redirect_to dispensers_url, notice: 'Dispenser was successfully created.' }
      else
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dispenser.update(dispenser_params)
        format.html { redirect_to dispensers_url, notice: 'Dispenser was successfully created.' }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @dispenser.destroy
        format.html { redirect_to dispensers_url, notice: 'Dispenser was successfully created.' }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_dispenser
    @dispenser = Dispenser.find(params[:id])
  end

  def dispenser_params
    params.require(:dispenser).permit(:flow_volume, :duration, :amount)
  end
end
