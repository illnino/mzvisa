Spree::User.class_eval do
	attr_accessible :username, :company, :phone, :spree_role_ids
	validates :username, :presence => true
	validates :company, :presence => true
	validates :phone, :presence => true, :length => { :in => 7..13 }
end
