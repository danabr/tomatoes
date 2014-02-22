# encoding: utf-8
module Tomatoes
  module Commands
    class Command < Struct.new(:tomato_box, :args, :out); end
  end
end
