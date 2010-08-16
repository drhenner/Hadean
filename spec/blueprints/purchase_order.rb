
PurchaseOrder.blueprint do 
  invoice_number        '21324124214'
  tracking_number       
  #notes
  ordered_at            Time.now
  estimated_arrival_on  Time.now.to_date
  is_received           true
end
