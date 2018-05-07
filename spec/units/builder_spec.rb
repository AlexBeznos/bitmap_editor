require 'spec_helper'
require 'builder'

RSpec.describe Bitmap::Builder do
  context 'when file path valid' do
    let(:path)     { './spec/fixtures/units/builder/basic.txt' }
    let(:executor) { spy('CommandExecutor') }
    let(:field)    { double('Field') }
    
    subject(:builder) { described_class.new(path) }

    it 'push splited lines from file into executor' do
      allow(Bitmap::Field).to receive(:new).and_return(field)
      allow(Bitmap::CommandExecutor).to receive(:new).with(field).and_return(executor)

      builder.build!

      expect(Bitmap::CommandExecutor).to have_received(:new).with(field)
      expect(executor).to have_received(:call).with('I', '5', '6')
      expect(executor).to have_received(:call).with('L', '1', '3', 'A')
      expect(executor).to have_received(:call).with('S')
    end
  end

  context 'when file path is invalid' do
    it 'raise InvalidFilePath' do
      expect { described_class.new('fake') }.to raise_error(Bitmap::Errors::InvalidFilePath)
    end
  end
end