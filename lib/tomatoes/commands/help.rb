# encoding: utf-8
require_relative 'command'

module Tomatoes
  module Commands
    class Help < Command
      def run
          out.puts "tomatoes - Manage your time"
          out.puts "Usage:"
          out.puts "$ tomatoes start  - Start a tomato"
          out.puts "$ tomatoes done   - Report tomato finished succesfully"
          out.puts "$ tomatoes fail   - Report tomato failed"
          out.puts "$ tomatoes status - Get status of current tomato"
      end
    end
  end
end
