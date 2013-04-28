# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/shared/_filters",
					 :name => "remove filters",
                     :remove =>"[data-hook='navigation']")
