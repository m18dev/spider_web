require 'spider_web'
require 'nokogiri'
require 'date'

describe 'HtmlClient' do
  it '#parse' do
    file = File.open('./spec/sample.html')
    doc = Nokogiri::HTML(file)
    client = HtmlClient.new
    rs = client.parse(doc)
    expect(rs[0].limit_time).to eq('23:48')
  end

  it '#assemble_url' do
    client = HtmlClient.new
    url = client.assemble_url('平和台', '溜池山王', Date.new(2015, 6, 7))
    expect(url).to eq('http://transit.loco.yahoo.co.jp/search/result?flatlon=&from=%E5%B9%B3%E5%92%8C%E5%8F%B0&to=%E6%BA%9C%E6%B1%A0%E5%B1%B1%E7%8E%8B&y=2015&m=6&d=7&type=2&ticket=ic&al=1&shin=1&ex=1&hb=1&lb=1&sr=1&s=0&expkind=1&ws=2&kw=%E6%BA%9C%E6%B1%A0%E5%B1%B1%E7%8E%8B')
  end
end
