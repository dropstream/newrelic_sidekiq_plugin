## NewRelic Sidekiq plugin

This plugin reports back metrics to the NewRelic plugin dashboard.

## Requirements

Ruby 1.9.3  
Sidekiq 2.13.0  

## Installation

    gem install newrelic_sidekiq_agent
    
## Getting Started

1. Copy `config/newrelic_plugin.yml.example` to `config/newrelic_plugin.yml`
2. Edit `config/newrelic_plugin.yml` and replace "YOUR_LICENSE_KEY_HERE" with your New Relic license key
3. run `./bin/newrelic_example_agent`
