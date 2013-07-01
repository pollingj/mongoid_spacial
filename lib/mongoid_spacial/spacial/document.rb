module Mongoid
  module Spacial
    module Document
      extend ActiveSupport::Concern

      included do
        attr_accessor :geo
        cattr_accessor :spacial_fields, :spacial_fields_indexed
        @@spacial_fields = []
        @@spacial_fields_indexed = []
      end

      module ClassMethods #:nodoc:
        # create spacial index for given field
        # @param [String,Symbol] name
        # @param [Hash] options options for spacial_index
        def spacial_index name, *options
          self.spacial_fields_indexed << name
          #index [[ name, ::Mongo::GEO2D ]], *options
          index({ name: "2d"}, *options)
        end
      end

      def distance_from(key,p2, opts = {})
        p1 = self.send(key)
        Mongoid::Spacial.distance(p1, p2, opts)
      end
    end
  end
end
