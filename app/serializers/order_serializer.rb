class OrderSerializer
  include FastJsonapi::ObjectSerializer
  cache_options enabled: true, cache_length: 12.hours

  belongs_to :user
  has_many :products
end
