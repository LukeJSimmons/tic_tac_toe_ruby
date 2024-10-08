require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  before do
    allow(board).to receive(:puts)
    allow(board).to receive(:print_board)
  end

  describe '#check_for_win' do
    before do
      allow(board).to receive(:exit)
    end

    describe 'wins' do
      context 'horizontal win' do
        subject(:board) { described_class.new([['X','X','X'],['#','#','#'],['#','#','#']]) }

        it 'X should win' do
          expect(board).to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end

      context 'vertical win' do
        subject(:board) { described_class.new([['X','#','#'],['X','#','#'],['X','#','#']]) }

        it 'X should win' do
          expect(board).to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end

      context 'diaganol win' do
        subject(:board) { described_class.new([['X','#','#'],['#','X','#'],['#','#','X']]) }

        it 'X should win' do
          expect(board).to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end
    end

    describe 'losses' do
      context 'horizontal loss' do
        subject(:board) { described_class.new([['X','#','X'],['#','#','#'],['#','#','#']]) }

        it 'X should not win' do
          expect(board).not_to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end

      context 'vertical loss' do
        subject(:board) { described_class.new([['X','#','#'],['#','#','#'],['X','#','#']]) }

        it 'X should not win' do
          expect(board).not_to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end

      context 'diaganol loss' do
        subject(:board) { described_class.new([['X','#','#'],['#','#','#'],['#','#','X']]) }

        it 'X should not win' do
          expect(board).not_to receive(:puts).with('X Wins!')
          board.check_for_win
        end
      end

      context 'cat game' do
        subject(:board) { described_class.new([['X','O','O'],['O','X','X'],['X','O','O']]) }

        it 'should display cat game' do
          expect(board).to receive(:puts).with('Cat Game!')
          board.check_for_win
        end
      end
    end
  end

  describe '#place' do
    context 'when space is empty' do
      it 'should place X in first round' do
        expect { board.place(0, 0) }.to change { board.instance_variable_get(:@board)[0][0] }.to('X')
      end

      it 'should place O in second round' do
        board.place(0,0)
        expect { board.place(1, 0) }.to change { board.instance_variable_get(:@board)[0][1] }.to('O')
      end
    end

    context 'when space is occupied' do
      it 'should return error' do
        expect(board).to receive(:puts).with('Place Taken: Please enter valid input')
        board.place(0,0)
        board.place(0,0)
      end

      it 'should not change occupied space' do
        board.place(0,0)
        expect { board.place(0,0) }.not_to change { board.instance_variable_get(:@board)[0][0] }
      end
    end
  end
end