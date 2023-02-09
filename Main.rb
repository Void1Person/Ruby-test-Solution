require 'open-uri'
require 'nokogiri'
require 'date'

url = 'https://agriculture.house.gov/news/documentsingle.aspx?DocumentID=2106'
page = Nokogiri::HTML(URI.open(url))

scrap_title = page.css('.single-headline')[0]

scrap_date = page.css('.topnewstext, b')[0].text.split[2..].join(' ').gsub(/[ ]/ ,"-").gsub(/[,]/ ,"")

scrap_location = page.css('topnewstext, b')[0].text.split[0].gsub(/[,]/ ,"")

scrap_article = page.css('bodycopy, p')[0..].text

pr_h = Hash.new
pr_h[:title] = scrap_title.at_css('.newsie-titler, h2').text
pr_h[:date] = DateTime.parse(scrap_date).to_date.to_s
pr_h[:location] = scrap_location
pr_h[:article] = scrap_article

puts pr_h
