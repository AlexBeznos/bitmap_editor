require_relative './base'

module Bitmap
  module Commands
    class Clear < Base
      def validate!(field_params, args)
        validation_schema do |v|
          v.eq?(args.count, 0)
          v.command_executable?(field_params[:commands], self.class)
        end
      end

      def execute!(field_params, _)
        field_params[:area].clear
      end
    end
  end
end