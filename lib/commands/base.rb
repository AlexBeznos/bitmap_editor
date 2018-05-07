require 'validation_helper'

module Bitmap
  module Commands
    class Base
      MAX_COORDINATE = 250
      MIN_COORDINATE = 1
      BASE_COLOR = 'O'.freeze

      def initialize(validator)
        @validator = validator
      end

      def validate!(*)
        raise NotImplementedError, 'each command should implement validate method'
      end

      def execute!(*)
        raise NotImplementedError, 'each command should implement call method'
      end

      private

      def validation_schema
        yield(@validator)
      end

      def prepare_coordinates(coordinates)
        coordinates.map(&:to_i)
      end
    end
  end
end