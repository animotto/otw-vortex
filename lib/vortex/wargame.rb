# frozen_string_literal: true

module Vortex
  ##
  # Wargame
  class Wargame
    def initialize(shell)
      @shell = shell
    end

    def exec(level)
      l = LevelBase.successors.detect { |s| s::LEVEL == level }
      if l.nil?
        @shell.puts("Level #{level} doesn't exist")
        return
      end

      l.new(@shell).exec
    end

    def levels
      LevelBase.successors.map { |s| s::LEVEL }
    end
  end
end
