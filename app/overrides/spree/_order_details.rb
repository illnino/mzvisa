# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/shared/_order_details",
					 :name => "remove payment",
                     :remove =>"div.row.steps-data")
