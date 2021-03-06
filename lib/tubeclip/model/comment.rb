class Tubeclip
  module Model
    class Comment < Tubeclip::Record
      attr_reader :content, :published, :title, :updated, :url, :reply_to

      # Tubeclip::Model::Author:: Information about the YouTube user who owns a piece of video content.
      attr_reader :author
      attr_reader :channel_id
      attr_reader :gp_user_id

      # unique ID of the comment.
      def unique_id
        url.split(":").last
      end
    end
  end
end

