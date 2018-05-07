require_relative './base'
require_relative './create_area'

module Bitmap
  module Commands
    class PaintPixel < Base
      def validate!(field_params, args)
        validation_schema do |v|
          v.eq?(args.count, 3)
          v.command_executable?(field_params[:commands], self.class)
          
          x, y, color = args

          v.each_number?([x, y])
          v.number_in_range?(x, 1..field_params[:cells_count])
          v.number_in_range?(y, 1..field_params[:rows_count])

          v.eq?(color.length, 1)
          v.upcase_letter?(color)
        end
      end

      def execute!(field_params, args)
        color = args.last
        x, y = *prepare_coordinates(args.slice(0, 2))

        field_params[:area][y - 1][x - 1] = color.to_sym
      end
    end
  end
end