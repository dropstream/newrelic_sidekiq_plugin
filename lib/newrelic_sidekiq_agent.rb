#
# This is a NewRelic Plugin Agent for monitoring Sidekiq
#
require "newrelic_plugin"
require "sidekiq"

module SidekiqAgent
  class Agent < NewRelic::Plugin::Agent::Base

    agent_guid "com.getdropstream.sidekiq"
    agent_version "0.0.2"
    agent_config_options :queue
    agent_human_labels("Sidekiq Agent") { ident }
    
    attr_reader :ident
    
    def setup_metrics
      @total_failed = NewRelic::Processor::EpochCounter.new
      @processed    = NewRelic::Processor::EpochCounter.new
    end
        
    def poll_cycle
      stats = Sidekiq::Stats.new
      
      # 
      # The # of worker executing a job 
      #
      report_metric "Workers/Working", "Workers", Sidekiq::Workers.new.size
      
      #
      # The # of queued jobs
      #
      report_metric "Jobs/Pending", "Jobs", stats.enqueued
      
      #
      # Total # of jobs failed
      #
      report_metric "Jobs/Failed", "Jobs", stats.failed
      
      #
      # Total # of jobs processed
      #
      report_metric 'Jobs/Processed', "Jobs", stats.processed
      
      #
      # The rate at which jobs are processed per second
      #
      report_metric "Jobs/Rate/Processed", "Jobs/Second", @processed.process(stats.processed)
      
      #
      # The rate at which jobs failed per second
      #
      report_metric "Jobs/Rate/Failed", "Jobs/Second", @total_failed.process(stats.failed)
    end

  end
end
