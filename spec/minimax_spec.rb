require 'minimax'

describe 'minimax' do
  describe 'given a binary tree with a depth of one' do
    describe "when it is the maximizer's turn" do
      it 'should return the larger leaf value' do
        result = minimax([3, 5, 2], true)

        expect(result).to eq(5)
      end
    end
    describe "when it is the minimizer's turn" do
      it 'should return the smaller leaf value' do
        result = minimax([3, 5, 4], false)

        expect(result).to eq(3)
      end
    end
  end
end
