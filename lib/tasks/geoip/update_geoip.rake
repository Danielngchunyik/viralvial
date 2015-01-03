namespace :geoip do
  desc 'update geoip city database'
  task :update_city do
    url = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
    system "curl #{url} | gzip -d > #{Rails.root.to_s}/db/geoip/GeoIP-city.dat"
  end

  desc 'update geoip country database'
  task :update_country do
    url = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
    system "curl #{url} | gzip -d > #{Rails.root.to_s}/db/geoip/GeoIP-country.dat"
  end
end