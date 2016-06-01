ENV['BUNDLE_GEMFILE']  ||=  File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'
require "yaml"
require 'will_paginate/per_page'
require 'rails'

PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)
APP_CONFIG = YAML.load_file(File.expand_path("#{PADRINO_ROOT}/config", __FILE__)+'/app_config.yml')[Rails.env]

WillPaginate.per_page = 3

CACHE_PREFIX = "msl12"