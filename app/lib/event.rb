require 'open-uri'
require 'zlib'
require 'json'

class Event
  attr_reader :after, :before, :type

  def initialize(options)
    @after = options[:after]
    @before = options[:before]
    @type = options[:type]
  end

  def github_url
    date = "#{url_year}-#{url_month}-#{url_day}-#{url_hour}"

    "http://data.githubarchive.org/#{date}.json.gz"
  end

  def json
    # http_object = open(github_url)
    # content = Zlib::GzipReader.new(http_object).read
    # Yajl::Parser.parse(content)
    # gz = open('http://data.githubarchive.org/2015-01-01-12.json.gz')
    json = []
    File.open('./spec/samples/2015-01-01-12.json', 'r') do |f|
      f.each_line do |line|
        json << JSON.parse(line)
      end
    end

    json.map { |e| e unless e['type'] != @type }.compact
  end

  def order
    ranking = {}

    json.each do |x|
      ranking[x['repo']['name']].nil? ? ranking[x['repo']['name'].to_sym] = 1 : ranking[x['repo']['name'].to_sym] += 1
    end

    ranking
  end

  private

  def url_year
    @after.year == @before.year ?
      @after.year : "20{#{(@after.year) - 2000}..#{(@before.year) - 2000}}"
  end

  def url_month
    if @after.month == @before.month
      two_digits(@after.month)
    else
      "{#{(two_digits(@after.month))}..#{(two_digits(@before.month))}}"
    end
  end

  def url_day
    if @after.day == @before.day
      two_digits(@after.day)
    else
      "{#{(two_digits(@after.day))}..#{(two_digits(@before.day))}}"
    end
  end

  def url_hour
    @after.hour == @before.hour ? @after.hour : "{#{(@after.hour)}..#{(@before.hour)}}"
  end

  def two_digits(number)
    (format('%02d', number))
  end
end
