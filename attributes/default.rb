default["graphite"]["version"]                              = "0.9.10"
default["graphite"]["home"]                                 = "/opt/graphite"
default["graphite"]["twisted_version"]                      = "13.1.0"
default["graphite"]["port"]                                 = "8080"
default["graphite"]["carbon"]["line_receiver_interface"]    = "127.0.0.1"
default["graphite"]["carbon"]["pickle_receiver_interface"]  = "127.0.0.1"
default["graphite"]["carbon"]["cache_query_interface"]      = "127.0.0.1"
default["graphite"]["carbon"]["log_updates"]                = false
default["graphite"]["carbon"]["whisper_dir"]                = "#{node["graphite"]["home"]}/storage/whisper"
default["graphite"]["carbon"]["max_cache_size"]             = "inf"
default["graphite"]["carbon"]["max_creates_per_minute"]     = "inf"
default["graphite"]["carbon"]["max_updates_per_second"]     = "1000"


# You can choose between "package" (for debian base OS) or "pip"
default['graphite_api']['install_method'] = 'pip'

default['graphite_api']['search_index'] = '/srv/graphite/index'
default['graphite_api']['time_zone'] = 'Europe/Berlin'
default['graphite_api']['functions'] = ['graphite_api.functions.SeriesFunctions', 'graphite_api.functions.PieFunctions']
default['graphite_api']['finders'] = []

# Whisper config
default['graphite_api']['whisper'] = {
  'enabled' => true,
  'directories' => ['#{node["graphite"]["home"]}/graphite/whisper']
}
if node['graphite_api']['whisper']['enabled'] == true
  default['graphite_api']['finders'] |= ['graphite_api.finders.whisper.WhisperFinder']
end

#Storage Schemas
default["graphite"]["storage_schemas"] = [
  {
    :stats => {
      :priority   => "100",
      :pattern    => "^stats\\..*",
      :retentions => "10s:7d,1m:31d,10m:5y"
    }
  },
  {
    :catchall => {
      :priority   => "0",
      :pattern    => "^.*",
      :retentions => "60s:5y"
    }
  }
]

#Storage Aggregation
default["graphite"]["storage_aggregation"] = [
  {
    :min => {
      :pattern            => "\\.min$",
      :xFilesFactor       => "0.1",
      :aggregationMethod  => "min"
    }
  },
  {
    :max => {
      :pattern            => "\\.max$",
      :xFilesFactor       => "0.1",
      :aggregationMethod  => "max"
    }
  },
  {
    :sum => {
      :pattern            => "\\.count$",
      :xFilesFactor       => "0",
      :aggregationMethod  => "sum"
    }
  },
  {
    :default_average => {
      :pattern            => ".*",
      :xFilesFactor       => "0.3",
      :aggregationMethod  => "average"
    }
  }
]
