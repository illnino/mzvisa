# encoding: utf-8
Deface::Override.new(:virtual_path  => "spree/shared/_user_form",
                     :insert_before => "div#password-credentials",
                     :text          => "<p><label for='user_username'>姓名</label><br><input class='title' id='user_username' name='user[username]' size='30' type='text'></p><p><label for='user_company'>公司</label><br><input class='title' id='user_company' name='user[company]' size='30' type='text'></p><p><label for='user_phone'>电话</label><br><input class='title' id='user_phone' name='user[phone]' size='30' type='text'></p>",
                     :name          => "registration_future")