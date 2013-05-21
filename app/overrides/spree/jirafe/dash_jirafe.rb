# Remove Jirafe's javascript script code from header of all pages
Deface::Override.new(:virtual_path => Spree::Config[:layout],
					:name => "remove_analytics_header",
					:remove => "script#analytics")

# Remove Jirafe's sidebar link from admin interface
Deface::Override.new(:virtual_path =>
					"spree/admin/shared/_configuration_menu",
					:name => "remove_dashboard_sidebar_link",
					:remove => "code[erb-loud]:contains('jirafe')")

# Remove Jirafe's content for head in admin interface
Deface::Override.new(:virtual_path => "spree/admin/overview/index",
					:name => "remove_head_content",
					:remove => "code[erb-silent]:contains('content_for
					:head')",
					:closing_selector => "code[erb-silent]:contains('end')")

