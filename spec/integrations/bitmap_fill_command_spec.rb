require 'spec_helper'
require 'builder'

RSpec.describe 'Bitmap creation' do
  let(:execute) { Bitmap::Builder.new(path).build! }
  let(:folder_path) { './spec/fixtures/integrations/bitmap_fill_command' }
  let(:path) { "#{folder_path}/#{test_name}/in.txt" }
  let(:out) { File.read("#{folder_path}/#{test_name}/out.txt") }

  describe 'basic' do
    let(:test_name) { 'basic' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'one-o-one' do
    let(:test_name) { 'one-o-one' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'blocking' do
    let(:test_name) { 'blocking' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'continious' do
    let(:test_name) { 'continious' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'diagonal' do
    let(:test_name) { 'diagonal' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'non-continious' do
    let(:test_name) { 'non-continious' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end

  describe 'large' do
    let(:test_name) { 'large' }
    
    it 'return correct output' do
      expect { execute }.to output(out).to_stdout
    end
  end
end