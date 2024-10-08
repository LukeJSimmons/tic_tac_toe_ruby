require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  before do
    allow(board).to receive(:puts)
  end

  describe '#check_for_win' do
    before do
      allow(board).to receive(:exit)
      allow(board).to receive(:print_board)
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
    before do
      allow(board).to receive(:print_board)
    end

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

  describe '#take_input' do
    before do
      allow(board).to receive(:print_board)
    end

    describe 'valid inputs' do
      context 'exit is typed' do
        before do
          allow(board).to receive(:gets).and_return('exit')
        end

        it 'exits game' do
          expect(board).to receive(:exit)
          board.take_input
        end
      end

      context 'valid x number is input' do
        before do
          allow(board).to receive(:gets).and_return('1')
        end

        it 'requests y number' do
          expect(board).to receive(:gets)
          board.take_input
        end
      end

      context 'valid y number is input' do
        before do
          allow(board).to receive(:gets).and_return('1', '1')
        end

        it 'calls place with x and y' do
          expect(board).to receive(:place).with(0, 0)
          board.take_input
        end
      end
    end

    describe 'invalid inputs' do
      context 'letter is input' do
        before do
          allow(board).to receive(:gets).and_return('g')
        end

        it 'displays error' do
          expect(board).to receive(:puts).with('Invalid Input: Please Input a Number Between 1 and 3')
          board.take_input
        end

        it 'calls print_board' do
          expect(board).to receive(:print_board)
          board.take_input
        end
      end

      context 'large number is input' do
        before do
          allow(board).to receive(:gets).and_return('11')
        end

        it 'displays error' do
          expect(board).to receive(:puts).with('Invalid Input: Please Input a Number Between 1 and 3')
          board.take_input
        end

        it 'calls print_board' do
          expect(board).to receive(:print_board)
          board.take_input
        end
      end

      context 'zero is input' do
        before do
          allow(board).to receive(:gets).and_return('0')
        end

        it 'displays error' do
          expect(board).to receive(:puts).with('Invalid Input: Please Input a Number Between 1 and 3')
          board.take_input
        end

        it 'calls print_board' do
          expect(board).to receive(:print_board)
          board.take_input
        end
      end

      context 'negative number is input' do
        before do
          allow(board).to receive(:gets).and_return('-5')
        end

        it 'displays error' do
          expect(board).to receive(:puts).with('Invalid Input: Please Input a Number Between 1 and 3')
          board.take_input
        end

        it 'calls print_board' do
          expect(board).to receive(:print_board)
          board.take_input
        end
      end
    end
  end

  describe '#print_board' do
    before do
      allow(board).to receive(:check_for_win)
      allow(board).to receive(:take_input)
    end

    context 'board is empty' do
      it 'displays empty board' do
        expected_output = "\n  1 2 3\n1 # # # \n2 # # # \n3 # # # \n\n"
        expect(board).to receive(:puts).with(expected_output)
        board.print_board
      end
    end

    context 'board is not empty' do
      subject(:board) { described_class.new([['X','O','X'],['X','O','#'],['O','#','#']]) }

      it 'displays board correctly' do
        expected_output = "\n  1 2 3\n1 X O X \n2 X O # \n3 O # # \n\n"
        expect(board).to receive(:puts).with(expected_output)
        board.print_board
      end
    end

    it 'calls check_for_win' do
      expect(board).to receive(:check_for_win)
      board.print_board
    end

    it 'calls take_input' do
      expect(board).to receive(:take_input)
      board.print_board
    end
  end
end