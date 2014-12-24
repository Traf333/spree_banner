module Spree
  module Admin
    class BannerBoxSettingsController < Spree::Admin::BaseController

      def show
        redirect_to( :action => :edit )
      end

      def create
        update_paperclip_settings
        @styles = ActiveSupport::JSON.decode(SpreeBanner::Config[:banner_styles])
        super
      end

      def edit
        @styles = ActiveSupport::JSON.decode(SpreeBanner::Config[:banner_styles])
      end

      def update
        update_styles(params)

        SpreeBanner::Config.set(params[:preferences])
        update_paperclip_settings

        respond_to do |format|
          format.html {
            flash[:notice] = t(:banner_settings_updated)
            redirect_to edit_admin_banner_box_settings_path
          }
        end
      end


      private

      def update_styles(params)
        params[:new_banner_styles].each do |index, style|
          params[:banner_styles][style[:name]] = style[:value] unless style[:value].empty?
        end if params[:new_banner_styles].present?

        styles = params[:banner_styles]

        SpreeBanner::Config[:banner_styles] = ActiveSupport::JSON.encode(styles) unless styles.nil?
      end

      def update_paperclip_settings
        Spree::BannerBox.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(SpreeBanner::Config[:banner_styles]).symbolize_keys!
        Spree::BannerBox.attachment_definitions[:attachment][:path] = SpreeBanner::Config[:banner_path]
        Spree::BannerBox.attachment_definitions[:attachment][:default_url] = SpreeBanner::Config[:banner_default_url]
        Spree::BannerBox.attachment_definitions[:attachment][:default_style] = SpreeBanner::Config[:banner_default_style]
      end
    end
  end
end
