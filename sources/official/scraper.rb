#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    POSITION_MAP = {
      'Minister of the Economy and Maritime Affairs' => ['Minister of the Economy', 'Minister of Maritime Affairs'],
    }.freeze

    def name
      noko.css('.name').text.tidy
    end

    def position
      POSITION_MAP.fetch(raw_position, raw_position)
    end

    field :start do
      noko.css('.period div').last.text[/(\d{4}-\d{2}-\d{2})/, 1]
    end

    private

    def raw_position
      noko.css('.title').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('div.item')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
