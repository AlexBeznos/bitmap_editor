require_relative './base'

module Bitmap
  module Commands
    class CreateArea < Base
      def validate!(field_params, args)
        validation_schema do |v|
          v.eq?(args.count, 2)
          v.command_executable?(field_params[:commands], self.class)
         
          v.each_number?(args)
          v.each_number_in_range?(args, MIN_COORDINATE..MAX_COORDINATE)
        end
      end

      def execute!(field_params, args)
        cells, rows = *prepare_coordinates(args)
        area = Array.new(rows) { Array.new(cells, BASE_COLOR) }
        
        field_params[:area].push(*area)
      end
    end
  end
end