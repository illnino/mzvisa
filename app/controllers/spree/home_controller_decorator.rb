Spree::HomeController.class_eval do

  def index
    slider = Spree::Taxon.where(:name => 'Slider').first
    @slider_products = slider.products.active if slider
  end

end