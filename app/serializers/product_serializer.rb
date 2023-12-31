class ProductSerializer

  include FastJsonapi::ObjectSerializer
  cache_options enabled: true, cache_length: 12.hours

  attributes :title, :price, :published

  belongs_to :user
end
