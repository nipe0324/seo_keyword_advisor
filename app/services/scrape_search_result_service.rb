require "open-uri"

class ScrapeSearchResultService
  GOOGLE_URL = 'http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8'

  def initialize(keyword)
    fail 'Keyword must be needed' if keyword.blank?
    @keyword = keyword
  end

  def call
    doc = Nokogiri.HTML(open(google_search_url))

    # liタグ以下を繰り返す
    doc.search("div#search ol li").each_with_index do |li, idx|
      href = ""
      html = ""
      link = ""

      # aタグの中身を解析
      li.search("h3 a").each do |alink|
        href = alink.attribute("href")
          URI.parse(href).query.split(/&/).each do |str|
          strs = str.split(/=/)
          link = strs[1] if strs[0] == "q"
        end
        html = alink.inner_html.gsub(/<.*>/, '')
      end

      # Webサイト以外（ニュースなど）はスキップ
      next if "#{href}" !~ /^\/url/

      # 結果表示
      keyword
      params = {
        keyword_id: @keyword.id,
        title:      html,
        desc:       'TODO',
        domain:     link.split("/")[2],
        url:        link,
        position:   idx + 1
      }
      Result.new(params).save!
    end
  end

  private

    def google_search_url
      "#{GOOGLE_URL}&#{search_query}"
    end

    def search_query
      { q: @keyword.name }.to_query
    end
end

# require "open-uri"

# class ScrapeSearchResultService
#   def initialize(keyword)
#     fail 'Keyword must be needed' if keyword.blank?
#     @keyword = keyword
#   end


#   # html structure of Google Search Result
#   #
#   # div[id=search]
#   # 　+ ol
#   # 　　+ li
#   # 　　　+ h3
#   # 　　　　+ a[href=/url?q=（★ここにリンク先URL★）&....）]
#   # 　　　　　+ （★ここにリンク文言★）
#   # 　　+ li
#   # 　　+ li
#   #
#   def call
#     doc = Nokogiri.HTML(open(google_search_url))

#     doc.search("div#search ol li").each_with_index do |li, idx|
#       alink = li.search("h3 a").first
#       href = alink.attribute("href")

#       next if not_website?(href)

#       title  = extract_title(alink)
#       desc   = extract_description(li)
#       url    = extract_url(href)
#       domain = extract_domain(url)

#       Result.clear
#       @keyword.results.save({
#         title:      title,
#         desc:       desc,
#         url:        url,
#         domain:     domain,
#         position:   idx + 1
#       })
#     end
#   end

#   private

#     def google_search_url
#       "http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&#{search_query}"
#     end

#     def search_query
#       { q: @keyword.name }.to_query
#     end

#     def not_website?(href)
#       href.to_s !~ /^\/url/
#     end

#     def extract_url(href)
#       URI.parse(href).query.split(/&/).map{|p| p.split("=")}.to_h["q"] rescue ''
#     end

#     def extract_domain(url)
#       URI.parse(link).hostname rescue ''
#     end

#     def extract_title(alink)
#       alink.inner_html.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '') rescue ''
#     end

#     def extract_description(li)
#       li.css('.st')[0].children.to_a.join rescue ''
#     end

# end
