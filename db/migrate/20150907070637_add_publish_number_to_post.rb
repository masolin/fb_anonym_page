class AddPublishNumberToPost < ActiveRecord::Migration
  def change
    add_column :posts, :publish_number, :integer
  end
end
