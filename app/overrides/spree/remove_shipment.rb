# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/users/show",
					 :name => "remove_order-shipment-state",
                     :remove =>".order-shipment-state")
