class Tubeclip
  module Model
    class Subscription < Tubeclip::Record
      attr_reader :id, :title, :published, :youtube_user_name
    end
  end
end
