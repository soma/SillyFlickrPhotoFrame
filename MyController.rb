# Controller.rb
# file
#
# Created by Albert Ramstedt on 2011-03-05.
# Copyright 2011 __MyCompanyName__. All rights reserved.
require 'rubygems'
require 'httparty'
require 'nokogiri'

class MyController < NSWindowController
  attr_accessor :image_holder, :tag
  
  def fetch(sender)
    im = FlickrImage.fetch(tag.stringValue())
    image_holder.image = im
  end
end

class FlickrImage
  def self.fetch(keyword)
    body = HTTParty.get("http://www.flickr.com/search/?w=all&q=#{keyword}&m=tags").body
    page = Nokogiri::HTML(body)
    url = page.search('.photo_container img').first['src']
    NSImage.alloc.initWithContentsOfURL(NSURL.URLWithString(url.gsub(/_t/, '_b_d')))
  end
end
