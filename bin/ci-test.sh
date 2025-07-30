#!/bin/bash

echo "Stopping Spring and cleaning up"
rm -f tmp/pids/server.pid
bin/spring stop || true

echo "Setting up test database config"
cp config/database.yml.github_actions config/database.yml

echo "Creating test database and loading schema (with DISABLE_SPRING)"
DISABLE_SPRING=1 RAILS_ENV=test bundle exec rails db:create db:migrate

echo "Running RSpec tests (with DISABLE_SPRING)"
DISABLE_SPRING=1 RAILS_ENV=test bundle exec rspec

echo "Running Rubocop linter"
bundle exec rubocop
