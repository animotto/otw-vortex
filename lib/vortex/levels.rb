# frozen_string_literal: true

require 'socket'

module Vortex
  ##
  # Level base
  class LevelBase
    class << self
      attr_reader :successors

      def inherited(subclass)
        super
        @successors ||= []
        @successors << subclass
      end
    end

    def initialize(shell)
      @shell = shell
    end

    def exec; end
  end
end
