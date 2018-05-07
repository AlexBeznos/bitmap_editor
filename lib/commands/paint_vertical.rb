require_relative './base'
require_relative './create_area'

module Bitmap
  module Commands
    class PaintVertical < Base
      def validate!(field_params, args)
        validation_schema do |v|
          v.eq?(args.count, 4)
          v.command_executable?(field_params[:commands], self.class)
          
          x, y1, y2, color = args

          v.each_number?([x, y1, y2])
          v.each_number_in_range?([y1, y2], 1..field_params[:rows_count])
          v.number_in_range?(x, 1..field_params[:cells_count])
          v.number_more_than?(y2, y1)
          
          v.eq?(color.length, 1)
          v.upcase_letter?(color)
        end
      end

      def execute!(field_params, args)
        color = args.last
        x, y1, y2 = *prepare_coordinates(args.slice(0, 3))
        
        (y1..y2).each do |y|
          field_params[:area][y-1][x-1] = color
        end
      end
    end
  end
end