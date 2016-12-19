require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

JAN_2016 = Time.new(2016,1,1).to_i
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
puts "Deleting files > 10MB for user #{user}"
count = 0

while page <= pages
  resp = client.files_list(user: uid, page: page)
  page = page + 1
  pages = resp.paging.pages

  resp.files.select { |f| f[:size] > 10 * ONE_MB }.each do |f|
    client.files_delete(f.id)
    count += 1
    print "."
  end
end
puts ""
puts "Deleted #{count} file(s) for #{user}"
