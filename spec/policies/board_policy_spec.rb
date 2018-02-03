describe BoardPolicy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:board) { create(:board) }

  permissions :show? do
    context 'denied access' do
      context 'for users' do
        before do
          user.board_permission_to_targets.create!(board: board, permission: BoardPermission.find_by!(name: 'can_access_board'), value: false)
        end

        it 'board permission :can_access_board is denied' do
          expect(subject).not_to permit(user, board)
        end
      end
    end

    context 'access granted' do
      context 'for users' do
        before do
          user.board_permission_to_targets.create!(board: board, permission: BoardPermission.find_by!(name: 'can_access_board'), value: true)
        end

        it 'board permission :can_access_board is allowed' do
          expect(subject).to permit(user, board)
        end
      end
    end
  end
end
