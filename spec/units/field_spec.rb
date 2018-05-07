require 'spec_helper'
require 'field'

RSpec.describe Bitmap::Field do
  describe '#persist!' do
    let(:fake_command) { double('Fake Command') }
    let(:fake_command_class) { 'Fake command class' }
    
    before do
      allow(fake_command).to(
        receive(:class)
          .and_return(fake_command_class)
      )
    end
    
    context 'when area empty' do
      let(:expected_params) do
        {
          area:        [],
          commands:    [],
          rows_count:  0,
          cells_count: 0
        }
      end
      let(:push_into_area) do
        lambda do |pr|
          pr[:area].push([1, 1, 1], [1, 1])
        end
      end

      it 'yields with correct params and add commant into queue' do
        subject.persist!(fake_command) do |params|
          expect(params).to eq(expected_params)
        end
        
        expect(subject.instance_variable_get(:@commands)).to eq([fake_command_class])
      end

      it 'raise an exception in case of area inconcistancy' do
        subject.persist!(fake_command, &push_into_area)

        expect { subject.persist!(fake_command, &push_into_area) }
          .to(
            raise_error(
              Bitmap::Errors::AreaInconsistent,
              "executions of some of this commands have led to area inconsistency #{fake_command_class}"
            )
          )
      end
    end

    context 'when area already changed' do
      let(:expected_area) { [[1, 2, 3], [4, 5, 6]] }

      it 'push into block correct params' do
        subject.persist!(fake_command) do |params|
          params[:area].push(*expected_area)
        end

        subject.persist!(fake_command) do |params|
          expect(params).to(
            eq(
              area:        expected_area, 
              commands:    [fake_command_class],
              rows_count:  2,
              cells_count: 3 
            )
          )
        end
      end
    end
  end
end