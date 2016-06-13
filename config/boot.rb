ENV['BUNDLE_GEMFILE']  ||=  File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'
require "yaml"
require 'will_paginate/per_page'
require 'rails'

RAILS_ROOT = File.expand_path('../..', __FILE__) unless defined?(RAILS_ROOT)
APP_CONFIG = YAML.load_file(File.expand_path("#{RAILS_ROOT}/config", __FILE__)+'/app_config.yml')[Rails.env]

WillPaginate.per_page = 5

CACHE_PREFIX = "msl12"