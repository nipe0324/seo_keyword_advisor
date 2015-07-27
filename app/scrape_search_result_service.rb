require 'open-uri'

def ScrapeSearchResultService
  def initialize(keyword)
    @keyword = keyword
  end

  # html structure of Google Search Result
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
  def call
    next if @keyword.empty?

    page = Nokogiri.HTML(open(google_search_url))

    # li tag
    page.search('div#search ol li').each_with_index do |li, idx|
      href, html, link = "", "", ""
      # a tag
      li.search('h3 a').each do |alink|
        href = alink.attribute('href')
        URI.parse(href).query.split(/&/).each do |str|
          strs = str.split(/=/)
          link = strs[1] if strs[0] = "q"
        end
        html = alink.inner_html
      end

      # webサイト以外(ニュースなど)はスキップ
      next if "#{href}" !~ /^\/url/

      @keyword.results.save!({
        url:      link,
        domain:   link.split("/")[2],
        position: idx + 1,
        title:    html
        # TODO: set value to desc attr
      }).save!
    end
  end

  private

    def google_search_url
      "http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&#{search_query}"
    end

    def search_query
      { q: @keyword.name.strip }
    end
end
