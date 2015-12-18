require 'spec_helper'

describe Event do
  it 'generate a list of urls to be downloaded' do
    after = DateTime.parse('2012-03-05T01:00:00Z')
    before = DateTime.parse('2014-05-23T23:00:00-03:00')

    event = Event.new after: after, before: before
    github_url = event.github_url

    expect(github_url)
      .to eq 'http://data.githubarchive.org/20{12..14}-{03..05}-{05..23}-{1..23}.json.gz'
  end

  it 'downloads and parses the given json' do
    after = DateTime.parse('2015-01-01T12:00:00')
    before = DateTime.parse('2015-01-01T12:00:00')
    json_file = './spec/samples/2015-01-01-12.json'
    json = []
    File.open(json_file, "r") do |f|
      f.each_line do |line|
        json << JSON.parse(line)
      end
    end

    event = Event.new after: after, before: before, type: 'PushEvent'

    expect(event.json.count).to eq 4284
  end
end
