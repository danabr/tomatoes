# encoding: utf-8
require_relative 'command'

module Tomatoes
  module Commands
    class Start < Command
      def run
        tomato_box.add args[0].to_s
        out.puts "Tomato started."
      end
    end
  end
end
