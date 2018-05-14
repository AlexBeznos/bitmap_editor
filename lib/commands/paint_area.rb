require_relative './base'

module Bitmap
  module Commands
    class PaintArea < Base
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

        x -= 1
        y -= 1
        
        current_color = field_params[:area][y][x]

        paint(
          x:             x,
          y:             y,
          current_color: current_color,
          color:         color,
          field_params:  field_params
        )
      end

      private

      def paint(**args)
        return unless args_suited?(args)
        area = args[:field_params][:area]
        x, y = args[:x], args[:y]
        
        area[y][x] = args[:color]

        paint(args.merge(x: x + 1))
        paint(args.merge(y: y + 1))
        paint(args.merge(x: x - 1))
        paint(args.merge(y: y - 1))
      end

      def args_suited?(x:, y:, field_params:, current_color:, **)
        belongs_to_area?(x, y, field_params) && field_params[:area][y][x] == current_color
      end

      def belongs_to_area?(x, y, field_params)
        (0..field_params[:cells_count]).cover?(x) &&
          (0..field_params[:rows_count]).cover?(y)
      end
    end
  end
end