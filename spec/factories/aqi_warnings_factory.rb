FactoryBot.define do
  factory :aqi_warning do
    user
    threshold { 10 }
    latitude { '19.002529441654687' }
    longitude { '-98.26751911537335' }
    location { 'Puebla México' }
  end
end
