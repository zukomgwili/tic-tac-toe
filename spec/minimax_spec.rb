require 'minimax'

describe 'minimax' do
  describe 'given a binary tree with a depth of one' do
    describe "when it is the maximizer's turn" do
      it 'should return the larger leaf value' do
        result = minimax([3, 5], true, 1, 0, 0)

        expect(result).to eq(5)
      end
    end
    describe "when it is the minimizer's turn" do
      it 'should return the smaller leaf value' do
        result = minimax([3, 5], false, 1, 0, 0)

        expect(result).to eq(3)
      end
    end
  end
  describe 'given a binary tree with a depth of two' do
    describe "when the maximizer looks ahead to see the minimizer's optimal moves" do
      it "should get the larger of the minimizer's moves" do
        result = minimax([3, 5, 2, 4], true, 2, 0, 0)

        expect(result).to eq(3)
      end
    end
    describe "when the minimizer looks ahead to see the maximizer's optimal moves" do
      it "should get the smaller of the maximizer's moves" do
        result = minimax([3, 5, 2, 4], false, 2, 0, 0)

        expect(result).to eq(4)
      end
    end
  end
  describe 'given a binary tree with a depth of three' do
    describe "when the maximizer looks ahead to see the minimizer's optimal moves" do
      it "should get the larger of the minimizer's moves" do
        result = minimax([3, 5, 2, 4, 1, 9, 8, 7], true, 3, 0, 0)

        expect(result).to eq(8)
      end
    end
    describe "when the minimizer looks ahead to see the maximizer's optimal moves" do
      it "should get the smaller of the maximizer's moves" do
        result = minimax([3, 5, 2, 4, 1, 9, 8, 7], false, 3, 0, 0)

        expect(result).to eq(3)
      end
    end
  end
  describe 'given a binary tree with a depth of four' do
    describe "when the maximizer looks ahead to see the minimizer's optimal moves" do
      it "should get the larger of the minimizer's moves" do
        result = minimax([3, 5, 2, 4, 1, 9, 8, 7, 9, 8, 7, 6, 5, 4, 3, 2], true, 4, 0, 0)

        expect(result).to eq(7)
      end
    end
    describe "when the minimizer looks ahead to see the maximizer's optimal moves" do
      it "should get the smaller of the maximizer's moves" do
        result = minimax([3, 5, 2, 4, 1, 9, 8, 7, 9, 8, 7, 6, 5, 4, 3, 2], false, 4, 0, 0)

        expect(result).to eq(4)
      end
    end
  end
end
