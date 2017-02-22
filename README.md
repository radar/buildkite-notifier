# Buildkite Notifier

The unofficial terminal notification thingo for Buildkite.

## Installation

1. Clone this repo.
2. Run `bundle install`.
2. [Generate a new API token for your user](https://buildkite.com/user/api-access-tokens) with the "Read Builds" option checked.
3. Export that token as `BUILDKITE_TOKEN` in your local `ENV`.
4. Install `terminal-notifier` (`brew install terminal-notifier`).

## Usage

1. Run `./buildkite.rb <org> <pipeline> <build number>`
2. See a notification come up when your build finishes.
3. :tada:



