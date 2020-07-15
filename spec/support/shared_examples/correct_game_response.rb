shared_examples 'renders the game correctly' do

  it 'responds with status code OK' do
    expect(response).to have_http_status(:ok)
  end

  it 'responds with the game board' do
    expect(response_body['board']).to eq(game.board)
  end
end
