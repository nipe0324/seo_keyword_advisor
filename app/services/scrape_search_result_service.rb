require "open-uri"

# Google Search Result HTML structure
#
# div[id=search]
# 　+ ol
# 　　+ li
# 　　　+ h3
# 　　　　+ a[href=/url?q=（★ここにリンク先URL★）&....）]
# 　　　　　+ （★ここにリンク文言★）
# 　　+ li
# 　　+ li
#
class ScrapeSearchResultService
  NO_DETECT = '取得できませんでした'

  def initialize(keyword)
    fail 'Keyword must be needed' if keyword.blank?
    @keyword = keyword
    @keyword.results.destroy_all
    @index = 1
  end

  def call
    doc = Nokogiri.HTML(open(google_search_url))

    doc.search("div#search ol li").each do |li|
      li.search("h3 a").each do |alink|
        href = alink.attribute("href")

        next if not_website?(href)

        title  = extract_title(alink)
        desc   = extract_description(li)
        url    = extract_url(href)
        domain = extract_domain(url)

        Result.create!({
          keyword_id: @keyword.id,
          title:      title,
          desc:       desc,
          url:        url,
          domain:     domain,
          position:   @index
        })
        @index += 1
      end
    end
  end

  private

    def google_search_url
      "http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&#{search_query}"
    end

    def search_query
      { q: @keyword.name }.to_query
    end

    def not_website?(href)
      href.to_s !~ /^\/url/
    end

    def extract_url(href)
      Rails.logger.info href
      URI.parse(href).query.split(/&/).map{|p| p.split("=")}.to_h["q"] rescue NO_DETECT
    end

    def extract_domain(url)
      Rails.logger.info url
      URI.parse(url).hostname rescue NO_DETECT
    end

    def extract_title(alink)
      alink.inner_html.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '') rescue NO_DETECT
    end

    def extract_description(li)
      li.css('.st')[0].children.to_a.join rescue NO_DETECT
    end

end
