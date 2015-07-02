## Description

Installs and configures Graphite.


It uses Graphite-API to serve data as JSON.


Much of the work in this cookbook reflects work done by
[Hetcastro](https://github.com/hectcastro/chef-graphite)

## Requirements

### Platforms

Tested on Ubuntu 12.04 (Precise)

Should work on:

* Amazon Linux 2013.03
* CentOS 6
* Red Hat 6
* Ubuntu 11.10 (Oneiric)

### Cookbooks

* graphite-api
* nginx
* logrotate
* python
* yum

## Attributes

* `node["graphite"]["version"]` - Version of Graphite to install.
* `node["graphite"]["home"]` - Prefix install directory for Graphite.
* `node["graphite"]["user"]` - User for Graphite and its components.
* `node["graphite"]["group"]` - Group for Graphite and its components.
* `node["graphite"]["twisted_version"]` - Attribute to explicitly set a
  version of Twisted prior to installing Carbon.
* `node["graphite"]["port"]` - Port on which the graphite webapp should
  be served
* `node["graphite"]["carbon"]["line_receiver_interface"]` - IP for the line
  receiver to bind to.
* `node["graphite"]["carbon"]["pickle_receiver_interface"]` - IP for the pickle
  receiver to bind to.
* `node["graphite"]["carbon"]["cache_query_interface"]` - IP for the query
  cache to bind to.
* `node["graphite"]["carbon"]["log_updates"]` - Enable/disable Carbon logging.
* `node["graphite"]["carbon"]["max_cache_size"]` - Maximum cache size (in points).
* `node["graphite"]["carbon"]["max_creates_per_minute"]` - Maximum creates per minute (in points).
* `node["graphite"]["carbon"]["max_updates_per_second"]` - Maximum updates per second (in points).
* `node["graphite"]["carbon"]["whisper_dir"]` - Location of whisper data files.
* `node["graphite"]["storage_schemas"]` - Array of hashes that define a storage
  schema.  See default attributes for an example.
* `node["graphite"]["storage_aggregation"]` – Array of hashes that define
  storage aggregation.  See default attributes for an example.

For Graphite-API attributes refer to this [cookbook](https://github.com/odolbeau/cookbook-graphite-api)

## Recipes

* `recipe[graphite]` will install Graphite and all of its components.
* `recipe[graphite::carbon]` will install Carbon.
* `recipe[graphite::whisper]` will install Whisper.

## Usage

This cookbook should be used in conjunction with a dashboard manager as Grafana.
Two schemas are provided by default:
`stats.*` for [StatsD](https://github.com/etsy/statsd) and a catchall that
matches anything.
