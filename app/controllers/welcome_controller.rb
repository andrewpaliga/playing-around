require 'rubygems'
require 'nokogiri'  
require 'open-uri'

class WelcomeController < ApplicationController

  $current_page = 1
  $url_page

  def index
 
  end

  def view
    $url_page = params[:url]
    hash_num = $url_page.to_s.split('/').last
    @base_url = $url_page.gsub(hash_num, "")
    $current_page = 1
    @page = Nokogiri::HTML(open(params[:url]))   
    @images = @page.css("table.regular-ad img")
    @title = @page.css("#SearchCategorySelected").text.titleize
    @ad_links = @page.css("table.regular-ad")
  end

  def view_next
    url = $url_page
    hash_num = url.to_s.split('/').last
    length_num = hash_num.length+2
    @page = url.insert(-length_num, '/page-'+$current_page.to_s)
    $current_page += 1
    @page = $url_page

    
  end

end
