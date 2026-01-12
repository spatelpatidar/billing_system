class DenominationsController < ApplicationController
  def destroy
    denomination = Denomination.find(params[:id])
    denomination.destroy
    redirect_to products_path, notice: "Denomination removed successfully"
  end
end
