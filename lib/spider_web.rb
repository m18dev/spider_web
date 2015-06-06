require 'nokogiri'
require 'open-uri'
require 'uri'
require 'date'
require "spider_web/version"

# お家に帰るためのルート
# 一応電車以外のことも考えてstationではなくentranceにしてあります。
class Route
  attr_reader :limit_time, :entrance
  def initialize(limit_time, entrance)
    @limit_time = limit_time
    @entrance = entrance
  end
end

class HtmlClient
  # 指定したURLのdocumentを取得する
  def get_document(url)
    Nokogiri::HTML(open(url))
  end

  # documentをparseしてRouteの配列を返します。
  def parse(doc)
    text = doc.css('#route01').css('.time').at_css('span').text
    [Route.new(text.split('発')[0], '')]
  end

  # 出発地点と目的地、日付を指定してURLを作成する。
  def assemble_url(from, to, today)
    "http://transit.loco.yahoo.co.jp/search/result?flatlon=&from=#{URI.escape(from)}&to=#{URI.escape(to)}&y=#{today.year}&m=#{today.month}&d=#{today.day}&type=2&ticket=ic&al=1&shin=1&ex=1&hb=1&lb=1&sr=1&s=0&expkind=1&ws=2&kw=%E6%BA%9C%E6%B1%A0%E5%B1%B1%E7%8E%8B"
  end

  def get_last_routes(from, to)
    url = assemble_url(from, to, Date.today())
    doc = get_document(url)
    parse(doc)
  end
end
