Spree::Taxon.class_eval do


  has_and_belongs_to_many :banners, join_table: 'banners_taxons', class_name: 'Spree::BannerBox', association_foreign_key: :banner_id

end