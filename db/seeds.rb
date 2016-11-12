require 'open-uri'
require 'nokogiri'

initial = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
set = Nokogiri::HTML(open(initial))
links = set.xpath("//div[@class='jsn-article-content']/ul/li/a").map{|link| link['href']}
links << '/learn-german/vocabulary/common-german-words'

links.each do |value|
  initial_inner = "http://www.languagedaily.com" + value
    set_inner = Nokogiri::HTML(open(initial_inner))
      td = set_inner.xpath("//div[@class = 'jsn-article-content']/table/tbody/tr").map{|td| td.text}
      td[1..-1].each do |td_value|
        tr = td_value.split(/\n/).reject(&:empty?)
        tr[2] = tr[2].gsub("'"){"\\'"}
        tr[3] = tr[3].gsub("'"){"\\'"}
        Card.create(original_text: tr[2], translated_text: tr[3])
      end
end

