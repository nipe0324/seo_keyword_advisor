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
