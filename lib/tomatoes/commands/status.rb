# encoding: utf-8
require_relative 'command'

module Tomatoes
  module Commands
    class Status < Command
      def run
        tomato = tomato_box.active_tomato
        if tomato.active?
          print_active_tomato(tomato)
        else
          out.puts "No active tomato"
        end
      end

      private

      def print_active_tomato(active)
        time_left = active.time_left_at(Time.now).round
        out.puts "Focus#{task_description(active)}! Time left: #{time_left}s"
      end

      def task_description(tomato)
        return "" if tomato.task =~ /^\s*$/
        " on #{tomato.task}"
      end
    end
  end
end
