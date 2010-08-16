class Admin::Inventory::ReceivingsController < ApplicationController
  def index
    # by default find all POs that are not received
    
    @purchase_orders = PurchaseOrder.receiving_admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @purchase_orders.to_jqgrid_json(
        [ :supplier_name, :invoice_number, :tracking_number, :display_estimated_arrival_on, :display_received ],
        @purchase_orders.per_page,
        @purchase_orders.current_page, 
        @purchase_orders.total_entries)

      }
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

end
