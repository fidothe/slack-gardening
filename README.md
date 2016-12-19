# Delete large files (> 10MB) from your user account

If you have to free up file storage space in a Slack team on a free plan, this
script will delete all files belonging to your user that are bigger than 10 MB.

It depends on the `slack-ruby-client` ruby gem.

You need to have a Slack API token and to know which team you're a member of
and want to delete files from.

## Usage

1. Download / clone this repository
2. Install dependencies using bundler:
    ```
    $ bundle install
    ```
2. Run the script, being careful to set the environment correctly
    ```
    $ SLACK_API_TOKEN=<your-token-here> SLACK_API_TEAM=<your-team-name> bundle exec ruby delete-large-files.rb
    ```

## License

This code is MIT licensed.
