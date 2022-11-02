require 'input'
require 'stringio'

describe Input do
  before do
    $stdin = StringIO.new('1 ')
  end

  after do
    $stdin = STDIN
  end

  describe 'get' do
    it 'should return square number submitted by player' do
      input = Input.new

      result = input.get

      expect(result).to eq(1)
    end
  end
end
