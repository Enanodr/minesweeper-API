# frozen_string_literal: true
require 'rails_helper'

describe Minesweeper::Builder do
  describe '#build' do
    context 'When building a 3x3 with a 1 bomb setting' do
      subject { Minesweeper::Builder.new(3,3,1) }

      it 'sets its board with only one bomb' do
        subject.build
        expect(subject.board.flatten.select { |cell| cell[:has_mine] }.count)
          .to eq(1)
      end

      it "sets the bomb's cell mines_near to -1" do
        subject.build
        every_bomb_is_negative_one =
          subject.board.flatten.select { |cell| cell[:has_mine] }
                               .map { |cell| cell[:mines_near] }
                               .all? { |n| n==-1 }
          expect(every_bomb_is_negative_one).to be_truthy
      end

      context 'and the bomb is in the middle field' do
        before do
          allow_any_instance_of(described_class)
            .to receive(:mine_locations)
            .and_return([4])
          subject.build
        end

        it 'sets all no-bomb cells with 1 near_bomb' do
          mines_near_map =
            subject.board.map { |row| row.map { |cell| cell[:mines_near] }}

          expect(mines_near_map)
            .to eq([
                [1, 1, 1],
                [1,-1, 1],
                [1, 1, 1]
            ])
        end
      end

      context 'and the bomb is in the upper left field' do
        before do
          allow_any_instance_of(described_class)
            .to receive(:mine_locations)
            .and_return([0])
          subject.build
        end

        it 'sets all no-bomb cells with 1 near_bomb' do
          expect(mines_near_map(subject.board))
            .to eq([
                [-1, 1, 0],
                [ 1, 1, 0],
                [ 0, 0, 0]
            ])
        end
      end
    end

    context 'When building a nxn with a multiple bomb setting' do
      context 'and the number of bombs fits the board' do
        let(:rows) { rand(2..30) }
        let(:cols) { rand(2..30) }
        let(:amount_of_mines) { rand(2..(rows * cols)) }

        subject { Minesweeper::Builder.new(rows, cols, amount_of_mines) }

        before { subject.build }

        it 'sets a board with the correct amount of bombs' do
          expect(subject.board.flatten.count { |cell| cell[:has_mine] })
            .to eq(amount_of_mines)
        end
      end
    end

    context 'When building a 10x7 with a 15 bomb setting' do
      context 'and the number of bombs fits the board' do
        let(:rows) { 10 }
        let(:cols) { 7 }
        let(:amount_of_mines) { 15 }

        subject { Minesweeper::Builder.new(rows, cols, amount_of_mines) }

        before do
          allow_any_instance_of(described_class)
            .to receive(:mine_locations)
            .and_return([3, 5, 7, 17, 22, 23, 28, 29,
                         33, 35, 38, 47, 52, 55, 57])
          subject.build
        end

        it 'sets all no-bomb cells with 1 near_bomb' do
          expect(mines_near_map(subject.board))
            .to eq([
              [0, 0, 1,-1, 2,-1, 3,-1, 2, 0],
              [0, 1, 3, 3, 3, 1, 3,-1, 4, 2],
              [0, 1,-1,-1, 3, 1, 2, 3,-1,-1],
              [0, 1, 3,-1, 3,-1, 2, 3,-1, 3],
              [0, 1, 2, 2, 3, 2, 4,-1, 3, 1],
              [0, 1,-1, 1, 1,-1, 3,-1, 2, 0],
              [0, 1, 1, 1, 1, 1, 2, 1, 1, 0],
            ])
        end
      end
    end
  end
end

def mines_near_map(board)
  board.map { |row| row.map { |cell| cell[:mines_near] }}
end
