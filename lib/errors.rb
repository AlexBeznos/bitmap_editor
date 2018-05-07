module Bitmap
  module Errors
    class InvalidFilePath < StandardError; end;
    class NotSupportedCommand < StandardError; end;
    class InvalidArguments < StandardError; end;
    class AreaInconsistent < StandardError; end;
  end
end