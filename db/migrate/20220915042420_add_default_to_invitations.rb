class AddDefaultToInvitations < ActiveRecord::Migration[7.0]
  def change
    change_column_default :invitations, :status, 0
  end
end
