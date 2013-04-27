# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/users/show",
					 :name => "remove_status",
                     :remove =>".order-status")
