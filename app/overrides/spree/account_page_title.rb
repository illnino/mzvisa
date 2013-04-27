# encoding: utf-8
Deface::Override.new(:virtual_path => "spree/users/show",
					 :name => "replace_h1",
                     :replace => "h1",
                     :text=> "<h2 class='my_account'>我的账户</h2>")
