require 'minimax'

describe 'minimax' do
  describe 'given a binary tree with a depth of one' do
    describe "when it is the maximizer's turn" do
      it 'should return the larger leaf value' do
        result = minimax([3, 5], true)

        expect(result).to eq(5)
      end
    end
    describe "when it is the minimizer's turn" do
      it 'should return the smaller leaf value' do
        result = minimax([3, 5], false)

        expect(result).to eq(3)
      end
    end
  end
  describe 'given a binary tree with a depth of two' do
    describe "when the maximizer looks ahead to see the minimizer's optimal moves" do
      it "should get the larger of the minimizer's moves" do
        result = minimax([3, 5, 2, 4], true)

        expect(result).to eq(3)
      end
    end
    describe "when the minimizer looks ahead to see the maximizer's optimal moves" do
      it "should get the smaller of the maximizer's moves" do
        result = minimax([3, 5, 2, 4], false)

        expect(result).to eq(4)
      end
    end
  end
end
