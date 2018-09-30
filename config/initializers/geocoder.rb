Geocoder.configure(
  # By default Geocoder will rescue any exceptions raised by calls
  # to a geocoding service and return an empty array.
  always_raise: :all

  # street address geocoding service (default :nominatim)
  # lookup: :yandex,

  # IP address geocoding service (default :ipinfo_io)
  # ip_lookup: :maxmind,

  # to use an API key:
  # api_key: "...",

  # geocoding service request timeout, in seconds (default 3):
  # timeout: 5,

  # set default units to kilometers:
  # units: :km,

  # caching (see [below](#caching) for details):
  # cache: Redis.new,
  # cache_prefix: "..."
)