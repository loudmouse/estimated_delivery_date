require 'date'
# https://github.com/bokmann/business_time
require 'business_time'

# https://stackoverflow.com/questions/4027768/calculate-number-of-business-days-between-two-days
class Date
  def dayname
     DAYNAMES[self.wday]
  end

  def abbr_dayname
    ABBR_DAYNAMES[self.wday]
  end
end

class Order

  system "clear"

  def get_status
    get_product
    get_shipping_method
    get_transit_time
    get_lead_time
    estimate_delivery_date
  end

  def get_product
    puts "Which product do you want to order?"
    puts "1 - Plaquemount"
    puts "2 - Floatmount"
    puts "3 - Flushmount"
    puts "4 - Box Frame"
    puts "5 - Canvas Wrap"
    puts "6 - Acrylic Facemount"
    puts "7 - Acrylic with Standoffs"
    puts "8 - Plaque Floater"
    puts "9 - Fine Art Frame"
    puts "10 - Lightbox"
    @product_type = gets.chomp.to_i
    get_production_time
  end

  def get_production_time
    if @product_type < 9
      @production_time = 5
    else
      @production_time = 10
    end
  end

  def get_shipping_method
    puts "Which shipping method would you like?"
    puts "4 - UPS Ground"
    puts "3 - UPS 3 Day Select"
    puts "2 - UPS 2nd Day Air"
    puts "1 - UPS Next Day Air"
    @shipping_method = gets.chomp.to_i
  end

  def get_transit_time
    if @shipping_method == 4
      @transit_time = 4
    elsif @shipping_method == 3
      @transit_time = 3
    elsif @shipping_method == 2
      @transit_time = 2
    else
      @transit_time = 1
    end
  end

  def get_lead_time
    @lead_time = @production_time + @transit_time
  end

  def estimate_delivery_date
    today = Date.today
    delivery_day_of_week = @lead_time.business_days.after(today).dayname
    # https://apidock.com/ruby/DateTime/strftime
    delivery_date = @lead_time.business_days.after(today).strftime('%D')
    puts "If you order today, your order would likely arrive on #{delivery_day_of_week}, #{delivery_date}."
  end
end

@order = Order.new
@order.get_status
