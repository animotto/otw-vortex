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

  ##
  # Level 0
  class Level0 < LevelBase
    LEVEL = 0

    HOST = 'vortex.labs.overthewire.org'
    PORT = 5842

    def exec
      @shell.puts("Connecting to #{HOST}:#{PORT}")
      socket = TCPSocket.new(HOST, PORT)

      @shell.puts('Reading data')
      data = socket.read(4 * 4)
      data = data.unpack('L4<')
      data.each do |v|
        @shell.puts(v)
      end

      response = data.inject(0) { |a, n| a += n }
      @shell.puts("Sending response: #{response}")
      response = [response].pack('L<')
      socket.write(response)

      @shell.puts('Reading credentials')
      credentials = socket.read
      @shell.puts(credentials)

      socket.close
    end
  end
end
