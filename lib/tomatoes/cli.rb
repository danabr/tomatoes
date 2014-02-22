# encoding: utf-8
require_relative 'commands/status'
require_relative 'commands/help'
require_relative 'tomato_box'

module Tomatoes
  # Command line interface
  class CLI
    def initialize(args)
      @args = args
    end

    def run
      command_args = @args[1..-1]
      command = command_factory.new(box, command_args, $stdout)
      command.run
    end

    private

    def command_factory
      case @args[0]
      when "status" then Commands::Status
      else
        Commands::Help
      end
    end

    def box
      TomatoBox.new("/tmp/tomatoes.csv")
    end
  end
end
