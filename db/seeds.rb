require 'open-uri'
require 'nokogiri'

@date_rec = Time.now + 259_200
@initial = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
@set = Nokogiri::HTML(open(@initial))
@links = @set.xpath("//div[@class='jsn-article-content']/ul/li/a").map{|link| link['href']}
@links << '/learn-german/vocabulary/common-german-words'
@links_count = @links.length - 1

(0..@links_count).each do |x|
  @initial_inner = "http://www.languagedaily.com" + @links[x]
  @set_inner = Nokogiri::HTML(open(@initial_inner))
  @original = @set_inner.xpath("//tr[@class='rowA' or @class='rowB']/td[2]").map{|td| td.text}
  @translation = @set_inner.xpath("//tr[@class='rowA' or @class='rowB']/td[3]").map{|td| td.text}
  @count = @original.length
    (0..@count).each do |i|
        if @translation[i].to_s.length > 10
          @original[i] = @original[i].gsub("'"){"\\'"}
          @translation[i] = @translation[i].gsub("'"){"\\'"}
          Card.create(original_text: @original[i], translated_text: @translation[i], review_date: @date_rec)
        end
      end
end
