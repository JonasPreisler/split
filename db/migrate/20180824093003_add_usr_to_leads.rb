class AddUsrToLeads < ActiveRecord::Migration[5.2]
  def change
    add_reference :leads, :user, foreign_key: true
  end
end