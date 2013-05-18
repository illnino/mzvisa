Spree::HomeController.class_eval do

  def index
    # slider = Spree::Taxon.where(:name => 'Slider').first
    # @slider_products = slider.products.active if slider

    promotion= Spree::Taxon.where(:name => 'Promotion').first
    @promotion_products = promotion.products.active if promotion

    # @news = Spree::Post.published
    @uploads = Spree::Upload.where(:alt => 'home')
  end

end