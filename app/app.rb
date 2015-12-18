require 'date'

class App
  attr_reader :after, :before, :event, :count

  def initialize(options)
    @after = DateTime.parse(options[:after])
    @before = DateTime.parse(options[:before])
    @event = options[:event]
    @count = options[:count]

    validate_input
  end

  def validate_input
    fail ArgumentError,
         'first date must be before the second date' unless dates_are_valid?

    fail ArgumentError,
         'you must inform a valid event' unless is_it_a_valid_event? event

    fail ArgumentError,
      'count must be an integer' unless /\A\d+\z/.match(@count)
  end

  def run
    'output'
  end

  private

  def dates_are_valid?
    @after < @before
  end

  def is_it_a_valid_event?(event)
    valid_events.map { |x| x == event ? true : false }.include? true
  end

  def valid_events
    %w(CommitCommentEvent CreateEvent DeleteEvent DeploymentEvent
       DeploymentStatusEvent DownloadEvent FollowEvent ForkEvent ForkApplyEvent 
       GistEvent GollumEvent IssueCommentEvent IssuesEvent MemberEvent
       MembershipEvent PageBuildEvent PublicEvent PullRequestEvent
       PullRequestReviewCommentEvent PushEvent ReleaseEvent RepositoryEvent
       StatusEvent TeamAddEvent WatchEvent)
  end
end

