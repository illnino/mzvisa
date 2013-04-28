# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/shared/_filters",
					 :name => "remove form",
                     :remove =>"form#sidebar_products_search")
