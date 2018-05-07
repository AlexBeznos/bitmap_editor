require 'errors'

module Bitmap
  class Field
    attr_reader :commands
    
    def initialize
      @commands, @area = [], []
    end

    def persist!(command)
      yield(params)
      @commands.push(command.class)
    end

    private

    def params
      {
        area:        @area, 
        commands:    @commands,
        rows_count:  @area.count,
        cells_count: cells_count
      }
    end

    def cells_count
      return 0 if @area.count.zero?

      cells_amount = @area.map(&:count).uniq
      raise_area_inconsistency if cells_amount.count > 1
      cells_amount.first
    end

    def raise_area_inconsistency
      commands = @commands.join(',')
      
      raise(
        Errors::AreaInconsistent, 
        "executions of some of this commands have led to area inconsistency #{commands}"
      )
    end
  end
end