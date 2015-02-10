module Spree
  module BannerBoxesHelper

    def insert_banner_box(params={})
      params[:category] ||= "home"
      params[:class] ||= "banner"
      params[:style] ||= SpreeBanner::Config[:banner_default_style]
      params[:limit] ||= 3
      banners = params[:collection] || Spree::BannerBox.enabled(params[:category]).order(:position).limit(params[:limit])
      return '' if banners.empty?
      content_tag :ul, class: 'banners' do
        banners.map do |ban|
          content_tag :li, :class => params[:class] do
            link_to (ban.url.blank? ? "javascript: void(0)" : ban.url) do
              src = ban.attachment.url(params[:style].to_sym)
              html_blocks = image_tag(ban.attachment.url(params[:style].to_sym), :alt => ban.alt_text.presence || image_alt(src))
              html_blocks += content_tag :div, ban.title, class: 'banner_title' if ban.title.present?
              html_blocks
            end
          end
        end.join.html_safe
      end
    end

  end
end
