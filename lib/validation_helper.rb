require 'errors'

Dir['./lib/commands/*.rb'].each { |p| require p }

module Bitmap
  class ValidationHelper
    def command_executable?(executed_commands, current_command)
      if current_command == Commands::CreateArea
        area_ready_for_create?(executed_commands)
      else
        area_ready_for_use?(executed_commands)
      end
    end

    def eq?(arg, target)
      return if arg == target
      raise_invalid_arguments
    end

    def each_number?(args)
      args.map(&method(:number?))
      return
    end

    def each_number_in_range?(args, range)
      args.map { |arg| number_in_range?(arg, range) }
      return
    end

    def number?(arg)
      return if arg =~ /\A\d+\z/
      raise_invalid_arguments
    end

    def number_in_range?(arg, range)
      return if range.cover?(arg.to_i)
      raise_invalid_arguments
    end

    def number_more_than?(first, second)
      return if first.to_i > second.to_i
      raise_invalid_arguments
    end

    def upcase_letter?(string)
      return if string =~ /[A-Z]/ && string.length == 1
      raise_invalid_arguments
    end

    private

    def area_ready_for_create?(executed_commands)
      create_index = executed_commands.rindex(Commands::CreateArea)
      clear_index  = executed_commands.rindex(Commands::Clear)

      return if create_index.nil?
      return if !clear_index.nil? && create_index < clear_index

      raise_invalid_arguments
    end

    def area_ready_for_use?(executed_commands)
      create_index = executed_commands.rindex(Commands::CreateArea)
      clear_index  = executed_commands.rindex(Commands::Clear)

      raise_invalid_arguments if create_index.nil?
      raise_invalid_arguments if !clear_index.nil? && clear_index > create_index
    end

    def raise_invalid_arguments
      raise Errors::InvalidArguments
    end
  end
end