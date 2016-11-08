class Tubeclip
  module Model
    class Message < Tubeclip::Record
      attr_reader :id, :name, :title, :summary, :published
      
      def content
        # This tag contains the same value as the <summary> tag.
        self.summary
      end
    end
  end
end
