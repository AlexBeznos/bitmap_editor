require 'spec_helper'
require 'command_executor'

RSpec.describe Bitmap::CommandExecutor do
  context 'when command supported' do
    let(:field) { double('Field') }
    let(:command) { spy('Bitmap::Commands::CreateArea') }
    let(:field_params) { 'some sort of fake field params' }
    let(:command_params) { [rand(10), rand(10), rand(10)] } 

    subject(:executor) { described_class.new(field) }

    it 'call validate! and execute! on command' do
      allow(Bitmap::Commands::CreateArea).to receive(:new).and_return(command)
      allow(field).to(
        receive(:persist!)
          .with(command) { |&block| block.call(field_params) }
      )
      allow(command).to(
        receive(:validate!)
          .with(field_params, command_params)
      )
      allow(command).to(
        receive(:execute!)
          .with(field_params, command_params)
      )

      executor.('I', *command_params)

      expect(command).to have_received(:validate!).with(field_params, command_params)
      expect(command).to have_received(:execute!).with(field_params, command_params)
    end
  end
  
  context 'when command not supported' do
    let(:field) { double('Field') }
    let(:execute) { described_class.new(field).('D', '1', '2') }

    it 'raise NotSupportedCommand' do
      expect { execute }.to raise_error(Bitmap::Errors::NotSupportedCommand)
    end
  end
end