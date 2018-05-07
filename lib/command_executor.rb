require 'errors'
require 'validation_helper'

Dir['./lib/commands/*.rb'].each { |p| require p }

module Bitmap
  class CommandExecutor
    def initialize(field)
      @field     = field
      @commands  = {
        'I' => Commands::CreateArea,
        'C' => Commands::Clear,
        'L' => Commands::PaintPixel,
        'V' => Commands::PaintVertical,
        'H' => Commands::PaintHorizontal,
        'S' => Commands::Show
      }
    end

    def call(literal_command, *args)
      command = prepare_command(literal_command)

      @field.persist!(command) do |field_params|
        command_params = [field_params, args]
        
        command.validate!(*command_params)
        command.execute!(*command_params)
      end
    end

    private

    def prepare_command(literal_command)
      command_class = @commands[literal_command]
      validator     = ValidationHelper.new
      raise(Errors::NotSupportedCommand) unless command_class
      
      command_class.new(validator)
    end
  end
end