#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Process the data from each source before comparison
class Comparison < EveryPoliticianScraper::NulllessComparison
  def external
    super.delete_if { |row| row[:position].to_s =~ /(secretary of state)|(deputy minister)/i }
  end

  def wikidata
    super.delete_if { |row| row[:position].to_s =~ /(secretary of state)|(deputy minister)/i }
  end
end

diff = Comparison.new('wikidata.csv', 'scraped.csv').diff
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
