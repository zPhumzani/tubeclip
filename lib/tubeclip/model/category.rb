class Tubeclip
  module Model
    class Category < Tubeclip::Record
      # *String*:: Name of the YouTube category
      attr_reader :label 
      
      # *String*:: Identifies the type of item described.
      attr_reader :term
    end
  end
end
