require 'input_output'
require 'stringio'

describe InputOutput do
  before do
    $stdin = StringIO.new('1 ')
  end

  after do
    $stdin = STDIN
  end

  describe 'in' do
    it 'should return square number submitted by player' do
      io = InputOutput.new

      result = io.in

      expect(result).to eq(1)
    end
  end

  describe 'out' do
    it 'should write to stdout' do
      io = InputOutput.new

      expect do
        io.out('Hello, world!')
      end.to output("Hello, world!\n").to_stdout
    end
  end
end
