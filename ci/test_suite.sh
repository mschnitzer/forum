#!/bin/bash
case $TEST_SUITE in
  rspec)
    bundle exec rake db:setup db:seed RAILS_ENV=test
    bundle exec rspec spec/ --fail-fast
    ;;
  rubocop)
    bundle exec rubocop -c .rubocop.yml .
    ;;
esac
