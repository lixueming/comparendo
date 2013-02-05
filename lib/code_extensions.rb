#!/bin/env ruby
# encoding: utf-8
module CodeExtensions
	PARSE_FOR_PATH = ->(str) {
    str = FILTER_UMLAUTS.(str)
    str.gsub(/[^a-zA-Z 0-9]/, "").gsub(/\s/,'-')
  }

  FILTER_UMLAUTS = ->(str) {
    str = str.gsub("ü","ue")
    str = str.gsub("ö","oe")
    str = str.gsub("ä","ae")
    str = str.gsub("ß","ss")
  }
end