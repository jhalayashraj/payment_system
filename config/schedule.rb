# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

env :PATH, ENV['PATH']
set :output, 'log/cron_log.log'

every :hour do
  runner 'CleanupTransactionsJob.perform_later(period: 1.hour.ago)'
end
