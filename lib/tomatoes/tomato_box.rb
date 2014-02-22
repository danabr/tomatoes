# encoding: utf-8
require_relative 'tomato'

module Tomatoes
  # Manages a collection of tomatoes
  class TomatoBox
    def initialize(path)
      @path = path
    end

    def tomatoes
      []
    end

    def active_tomato
      NonExistantTomato.new
    end
  end
end
