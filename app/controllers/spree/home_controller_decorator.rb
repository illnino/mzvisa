Spree::HomeController.class_eval do

  def index
    slider = Spree::Taxon.where(:name => 'Slider').first
    @slider_products = slider.products.active if slider

    promotion= Spree::Taxon.where(:name => 'Promotion').first
    @promotion_products = promotion.products.active if promotion
  end

end