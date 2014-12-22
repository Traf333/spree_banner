class AddTitleToBannerBoxes < ActiveRecord::Migration
  def change
    add_column :spree_banner_boxes, :title, :string
  end
end
