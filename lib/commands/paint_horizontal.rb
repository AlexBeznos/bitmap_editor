require_relative './base'
require_relative './create_area'

module Bitmap
  module Commands
    class PaintHorizontal < Base
      def validate!(field_params, args)
        validation_schema do |v|
          v.eq?(args.count, 4)
          v.command_executable?(field_params[:commands], self.class)
          
          x1, x2, y, color = args

          v.each_number?([x1, x2, y])
          v.each_number_in_range?([x1, x2], 1..field_params[:cells_count])
          v.number_in_range?(y, 1..field_params[:rows_count])
          v.number_more_than?(x2, x1)

          v.eq?(color.length, 1)
          v.upcase_letter?(color)
        end
      end

      def execute!(field_params, args)
        color = args.last
        x1, x2, y = *prepare_coordinates(args.slice(0, 3))
        
        (x1..x2).each do |x|
          field_params[:area][y - 1][x - 1] = color
        end
      end
    end
  end
end