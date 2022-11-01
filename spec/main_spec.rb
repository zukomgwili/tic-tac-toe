require './main'
require 'stringio'

describe 'main' do
  after do
    $stdin = STDIN
  end

  it 'should start game' do
    $stdin = StringIO.new('0')
    expect do
      main
    end.to_not raise_error(StandardError)
  end
end
