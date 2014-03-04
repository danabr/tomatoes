# encoding: utf-8
require_relative 'tomato'
require 'csv'
require 'time'

module Tomatoes
  class InvalidTomato < StandardError; end

  # Manages a collection of tomatoes
  class TomatoBox
    attr_reader :tomatoes

    def initialize(path)
      @path = path
      @tomatoes = []
      read_csv if file_exists?
    end

    def active_tomato
      candidate = tomatoes.last
      if candidate && candidate.active?
        candidate
      else
        NonExistantTomato.new
      end
    end

    private

    def file_exists?
      File.exist?(@path)
    end

    def read_csv
      headers = nil
      CSV.foreach(@path, csv_opts) do |row|
        if headers.nil?
          headers = row
        else
          tomatoes << CsvRow.new(headers, row).to_tomato
        end
      end
    end

    def csv_opts
      { encoding: "utf-8", col_sep: "\t" }
    end

    class CsvRow
      attr_reader :parsed_row
      def initialize(headers, row)
        @parsed_row = {}
        row.each_with_index do |value, column_index|
          header = headers[column_index]
          parsed_row[header] = value
        end
      end

      def to_tomato
        if has_required_headers?
          Tomato.new(parsed_row["task"],
                     Time.parse(parsed_row["start_time"]),
                     Time.parse(parsed_row["end_time"]),
                     parsed_row["state"])
        else
          raise InvalidTomato.new(parsed_row.inspect)
        end
      end

      private

      def has_required_headers?
        !required_headers.any? { |h| parsed_row[h].nil? || parsed_row[h].empty? }
      end

      def required_headers
        ["task", "start_time", "end_time", "state"]
      end
    end
  end
end
