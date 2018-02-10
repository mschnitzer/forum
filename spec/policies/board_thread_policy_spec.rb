describe BoardThreadPolicy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:board_category) { create(:board_category) }
  let(:board_thread) { create(:board_thread, user: user, board_id: board_category.id) }

  permissions :new? do
    context 'deny access' do
      it 'for board categories' do
        expect(subject).not_to permit(user, board_thread)
      end
    end
  end
end
