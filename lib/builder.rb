require 'command_executor'
require 'field'
require 'errors'

module Bitmap
  class Builder
    def initialize(path)
      validate_path!(path)

      @path      = path
      @field     = Field.new
      @executor  = CommandExecutor.new(@field)
    end

    def build!      
      File.read(@path).each_line do |line|
        @executor.(*line.split)
      end
    end

    private

    def validate_path!(path)
      raise Errors::InvalidFilePath unless File.exist?(path)
    end
  end
end