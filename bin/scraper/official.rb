#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.name').text.tidy
    end

    def position
      noko.css('.title').text.tidy
    end

    field :start do
      noko.css('.period div').last.text[/(\d{4}-\d{2}-\d{2})/, 1]
    end
  end

  class Members
    def member_container
      noko.css('div.item')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
