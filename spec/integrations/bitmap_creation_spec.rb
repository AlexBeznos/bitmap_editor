require 'spec_helper'
require 'builder'

RSpec.describe 'Bitmap creation' do
  let(:execute) { Bitmap::Builder.new(path).build! }
  let(:folder_path) { './spec/fixtures/integrations/bitmap_creation' }
  let(:path) { "#{folder_path}/#{test_name}/in.txt" }
  let(:out) { File.read("#{folder_path}/#{test_name}/out.txt") }

  describe 'basic' do
    let(:test_name) { 'basic' }
      
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'complex' do
    let(:test_name) { 'complex' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'when area not created' do
    let(:test_name) { 'no_area' }
    
    it 'return correct output' do
      expect { execute }.to raise_error(Bitmap::Errors::InvalidArguments)
    end
  end

  describe 'when command not exists' do
    let(:test_name) { 'no_command' }
    
    it 'return correct output' do
      expect { execute }.to raise_error(Bitmap::Errors::NotSupportedCommand)
    end
  end

  describe 'when nothing to show' do
    let(:test_name) { 'nothing_to_show' }
    
    it 'return correct output' do
      expect { execute }.to raise_error(Bitmap::Errors::InvalidArguments)
    end
  end

  describe 'when out of area' do
    let(:test_name) { 'out_of_area' }
    
    it 'return correct output' do
      expect { execute }.to raise_error(Bitmap::Errors::InvalidArguments)
    end
  end
end