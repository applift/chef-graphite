default["graphite"]["version"]                              = "0.9.10"
default["graphite"]["home"]                                 = "/opt/graphite"
default["graphite"]["twisted_version"]                      = "13.1.0"
default["graphite"]["port"]                                 = "80"
default["graphite"]["carbon"]["line_receiver_interface"]    = "127.0.0.1"
default["graphite"]["carbon"]["pickle_receiver_interface"]  = "127.0.0.1"
default["graphite"]["carbon"]["cache_query_interface"]      = "127.0.0.1"
default["graphite"]["carbon"]["log_updates"]                = true
default["graphite"]["carbon"]["whisper_dir"]                = "#{node["graphite"]["home"]}/storage/whisper"
default["graphite"]["carbon"]["max_cache_size"]             = "inf"
default["graphite"]["carbon"]["max_creates_per_minute"]     = "inf"
default["graphite"]["carbon"]["max_updates_per_second"]     = "1000"

default['graphite']['web']['secretkey'] = '0aed5c39507562f4519c2d47515e8221'
default['graphite']['web']['timezone'] = 'Europe/Dublin'
default['graphite']['web']['server'] = 'uwsgi'
default["graphite"]["web"]["memcache_hosts"]          = ""
default["graphite"]["web"]["mysql_server"]            = ""
default["graphite"]["web"]["mysql_port"]              = ""
default["graphite"]["web"]["mysql_username"]          = ""
default["graphite"]["web"]["mysql_password"]          = ""

# This does not update after initial setup
default['graphite']['web']['seed_password'] = 'changeme'

# These defaults are overridden in the _nginx recipe
default['graphite']['uwsgi']['listen_ip']   = '0.0.0.0'
default['graphite']['uwsgi']['listen_port'] = 8080

# The template will use the host's FQDN unless this attribute is set
default['graphite']['nginx']['hostname'] = nil
default['graphite']['nginx']['disable_default_vhost'] = false

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
