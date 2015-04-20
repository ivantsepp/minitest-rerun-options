module Minitest
  def self.plugin_rerun_options_options(opts, options)
    opts.on '--names x,y,z', Array, "Run specified test names" do |names|
      options[:names] = names
    end
  end

  def self.plugin_rerun_options_init(options)
    reporter.reporters << RerunOptionsReporter.new

    options[:filter] = "/#{options[:names].join('|')}/" if options[:names] && !options[:names].empty?
  end

  class RerunOptionsReporter < StatisticsReporter
    def report
      return if results.empty?

      names = results.collect do |result|
        "#{result.class.name}##{result.name}"
      end

      io.puts
      io.puts "Rerun failed tests options:"
      io.puts rerun_options_for(names)
      io.puts
    end

    private

    def rerun_options_for(names)
      $0.include?("rake_test_loader") ? rake_options_for(names) : ruby_options_for(names)
    end

    def ruby_options_for(names)
      options = names.collect do |name|
        single_run_option_for(name)
      end.join("\n")
      options << "\n#{multiple_run_option_for(names)}" if names.length > 1
      options
    end

    def rake_options_for(names)
      options = names.collect do |name|
        "TEST_OPTS=\"#{single_run_option_for(name)}\""
      end.join("\n")
      options <<  "\nTEST_OPTS=\"#{multiple_run_option_for(names)}\"" if names.length > 1
      options
    end

    def single_run_option_for(name)
      "--name #{name}"
    end

    def multiple_run_option_for(names)
      "--names #{names.join(',')}"
    end
  end
end
