Deface::Override.new(:virtual_path => 'spree/layouts/admin',
                     :name => "add_ckeditor_header",
                     :insert_bottom => 'head',
                     :partial => "spree/admin/editor/ckeditor")