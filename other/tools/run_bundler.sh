#!/bin/bash

echo "Running bundler"
bundle config set path vendor/bundle
bundle install