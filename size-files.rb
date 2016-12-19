require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

ONE_MB = 1_000_000

client = Slack::Web::Client.new

to_delete = []
page = 1
pages = 1
total_size = []

resp = client.auth_test
user = resp.user
uid = resp.user_id
team = resp.team

raise ArgumentError, "API token is not for the #{ENV['SLACK_API_TEAM']} team!" if team != ENV['SLACK_API_TEAM']

while page <= pages
  resp = client.files_list(user: uid, page: page)
  page = page + 1
  pages = resp.paging.pages

  total_size = resp.files.inject(0) { |t, f| t + f[:size] }
end

def in_mb(size)
  (size / ONE_MB.to_f).round(2)
end

puts "User #{user} has #{in_mb(total_size)} MB files"
