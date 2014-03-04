# encoding: utf-8
require_relative 'command'

module Tomatoes
  module Commands
    class Status < Command
      def run
        tomato = tomato_box.active_tomato
        if tomato.overdue_at?(Time.now)
          print_overdue_tomato(tomato)
        elsif tomato.active?
          print_active_tomato(tomato)
        else
          out.puts "No active tomato"
        end
      end

      private

      def print_overdue_tomato(tomato)
        description = tomato.task
        description = "The task" if description.empty?
        out.puts "#{description} has finished."
        out.puts "Report success or failure with tomatoes done or tomatoes fail."
      end

      def print_active_tomato(tomato)
        description = "" if tomato.task.empty?
        description ||= " on #{tomato.task}"
        time_left = tomato.time_left_at(Time.now).round
        out.puts "Focus#{description}! Time left: #{time_left}s"
      end

      def focus_description(tomato)
      end

    end
  end
end
