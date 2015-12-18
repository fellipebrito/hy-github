require 'spec_helper'

describe App do
  context 'the user does not provide all the necessary inputs' do
    it 'returns an argument error if something is missing' do
      expect { App.new }.to raise_error(ArgumentError)

      expect { App.new(after: 'after') }.to raise_error(ArgumentError)

      expect do
        App.new(after: 'after',
                before: 'before')
      end.to raise_error(ArgumentError)

      expect do
        App.new(after: 'after',
                before: 'before',
                event: 'event')
      end.to raise_error(ArgumentError)
    end

    it 'raises an error if after and before are not a date' do
      expect do
        App.new(after: 'after',
                before: 'before',
                event: 'event',
                count: 'count')
      end
        .to raise_error(ArgumentError, 'invalid date')

      expect do
        App.new(after: '2012-11-01T13:00:00Z',
                before: 'before',
                event: 'event',
                count: 'count')
      end
        .to raise_error(ArgumentError)
    end

    it 'raises an error if after is a date previous before' do
      expect do
        App.new(after:  '2012-12-01T13:00:00Z',
                before: '2012-11-02T03:12:14-03:00',
                event: 'event',
                count: 'count')
      end
        .to raise_error(ArgumentError,
                        'first date must be before the second date')
    end

    it 'raises an error if the event is not valid' do
      expect do
        App.new(after: '2012-11-01T13:00:00Z',
                before: '2012-11-02T03:12:14-03:00',
                event: 'event',
                count: 'count')
      end
        .to raise_error(ArgumentError,
                        'you must inform a valid event')
    end

    it 'raises an error if the count is not an integer' do
      expect do
        App.new(after: '2012-11-01T13:00:00Z',
                before: '2012-11-02T03:12:14-03:00',
                event: 'CommitCommentEvent',
                count: 'count')
      end
        .to raise_error(ArgumentError,
                        'count must be an integer')
    end
  end

  it 'receives an user input and returns the correct output' do
    app = App.new(after: '2012-11-01T13:00:00Z',
                  before: '2012-11-02T03:12:14-03:00',
                  event: 'CommitCommentEvent',
                  count: '15')
    expect(app.run).to eq 'output'
  end
end
