# frozen_string_literal: true

require 'rails_helper'

describe Minesweeper::BoardState do
  describe '#discover_cell' do
    subject(:board_state) { described_class.new(board) }

    include_context 'with a 4 x 4 board with one mine in the corner'

    context 'when coordinates are valid' do
      context 'with with a near mine cell' do
        before { board_state.discover_cell(2, 0) }

        it 'marks the cell as discovered' do
          expect(board_state.serialize[0][2][:state])
            .to eq(:exposed)
        end

        it 'does not discover any other cell' do
          hidden_cells_count = board_state.serialize.flatten.count do |cell|
            cell[:state] == :hidden
          end
          expect(hidden_cells_count)
            .to eq(board_state.serialize.flatten.count - 1)
        end
      end

      context 'with with a mine cell' do
        before { board_state.discover_cell(3, 0) }

        it 'marks the cell as discovered' do
          expect(board_state.serialize[0][3][:state])
            .to eq(:exposed)
        end

        it 'does not discover any other cell' do
          hidden_cells_count = board_state.serialize.flatten.count do |cell|
            cell[:state] == :hidden
          end
          expect(hidden_cells_count)
            .to eq(board_state.serialize.flatten.count - 1)
        end
      end

      context 'with with a no-near mine cell' do
        before { board_state.discover_cell(0, 0) }

        it 'marks all no near mine cells as discovered' do
          exposed_cells_count = board_state.serialize.flatten.count do |cell|
            cell[:state] == :exposed
          end
          expect(exposed_cells_count)
            .to eq(board_state.serialize.flatten.count - 1)
        end

        it 'leaves the mine hidden' do
          expect(board_state.serialize[0][3][:state])
            .to eq(:hidden)
        end
      end
    end
  end
end
