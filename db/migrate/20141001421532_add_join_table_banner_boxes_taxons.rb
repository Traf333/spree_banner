class AddJoinTableBannerBoxesTaxons < ActiveRecord::Migration
  def change
    create_table :banners_taxons, id: false do |t|
      t.integer :banner_id
      t.integer :taxon_id

      t.index [:banner_id, :taxon_id]
      t.index [:taxon_id, :banner_id]
    end
  end
end
