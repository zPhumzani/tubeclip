class Tubeclip
  module Model
    class Playlist < Tubeclip::Record
      attr_reader :title, :description, :summary, :author, :videos_count, :playlist_id, :xml, :published, :response_code
      def videos
        Tubeclip::Parser::VideosFeedParser.new(@xml).parse_videos
      end
    end
  end
end

