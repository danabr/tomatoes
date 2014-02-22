# encoding: utf-8
require_relative 'command'

module Tomatoes
  module Commands
    class Status < Command
      def run
        out.puts "No active tomato"
      end
    end
  end
end
