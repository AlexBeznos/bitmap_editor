require 'spec_helper'
require 'validation_helper'

RSpec.describe Bitmap::ValidationHelper do
  describe '#command_executable?' do
    context 'when current command is Commands::CreateArea' do
      let(:current_command) { Bitmap::Commands::CreateArea }

      it do
        expect(subject.command_executable?([], current_command)).to be_nil
      end

      it do
        expect(
          subject.command_executable?(
            [Bitmap::Commands::CreateArea, Bitmap::Commands::Clear], 
            current_command
          )
        ).to be_nil
      end

      it do
        expect do
          subject.command_executable?(
            [Bitmap::Commands::Clear, Bitmap::Commands::CreateArea], 
            current_command
          )
        end.to raise_error(Bitmap::Errors::InvalidArguments)
      end
    end

    context 'when current command any except Commands::CreateArea' do
      let(:current_command) do
        [
          Bitmap::Commands::Clear,
          Bitmap::Commands::PaintHorizontal,
          Bitmap::Commands::PaintPixel,
          Bitmap::Commands::PaintVertical,
          Bitmap::Commands::Show
        ].sample
      end

      it do
        expect { subject.command_executable?([], current_command) }.to(
          raise_error(Bitmap::Errors::InvalidArguments)
        )
      end

      it do
        commands = [Bitmap::Commands::CreateArea, Bitmap::Commands::Clear]
        expect { subject.command_executable?(commands, current_command) }.to(
          raise_error(Bitmap::Errors::InvalidArguments)
        )
      end

      it do
        commands = [Bitmap::Commands::CreateArea, Bitmap::Commands::PaintPixel]
        expect(subject.command_executable?(commands, current_command)).to be_nil
      end
    end
  end

  describe '#eq?' do
    it 'returns nil when values equal' do
      expect(subject.eq?(1, 1)).to be_nil
    end

    it 'raise InvalidArguments when not equal' do
      expect { subject.eq?(1, 2) }.to raise_error(Bitmap::Errors::InvalidArguments)
    end
  end

  describe '#each_number?' do
    it 'returns nil when each string is a number' do
      expect(subject.each_number?(['1', '2', '234', '2352345'])).to be_nil
    end

    it 'raise InvalidArguments when some of string is not a number' do
      expect { subject.each_number?(['1', 'd', '23', 'd21']) }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end
  end

  describe '#each_number_in_range?' do
    it 'return nil when each number belongs to range' do
      expect(subject.each_number_in_range?(['1', '2', '3'], 1..3)).to be_nil
    end

    it 'raise InvalidArguments when some of numbers not belongs to range' do
      expect { subject.each_number_in_range?(['1', '5', '3'], 1..3) }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end
  end

  describe '#number?' do
    it { expect(subject.number?('12341135')).to be_nil }

    it do 
      expect { subject.number?('234d324') }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end
  end

  describe '#number_in_range?' do
    it { expect(subject.number_in_range?('213', 100..300)).to be_nil }
    
    it do
      expect { subject.number_in_range?('456', 100..300) }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end
  end

  describe '#number_more_than?' do
    it { expect(subject.number_more_than?('2', '1')).to be_nil }
    
    it do
      expect { subject.number_more_than?('1', '2') }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end 
  end

  describe '#upcase_letter?' do
    it { expect(subject.upcase_letter?('D')).to be_nil }
    it do
      expect { subject.upcase_letter?('d') }.to(
        raise_error(Bitmap::Errors::InvalidArguments)
      )
    end
  end

end
