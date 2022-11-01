require './main'
require 'stringio'

describe 'main' do
  skip 'should start game' do
    expect do
      main
    end.to_not raise_error(StandardError)
  end
end
