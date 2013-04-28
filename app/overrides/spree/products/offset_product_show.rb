# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/products/show",
					 :name => "remove payment",
                     :set_attributes =>"[data-hook='product_show']",
                     :attributes => {:class => 'content-padding'})
