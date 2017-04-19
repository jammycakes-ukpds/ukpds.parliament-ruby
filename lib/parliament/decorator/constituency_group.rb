module Parliament
  module Decorator
    # Decorator namespace for Grom::Node instances with type: http://id.ukpds.org/schema/ConstituencyGroup
    module ConstituencyGroup
      # Alias constituencyGroupName with fallback.
      #
      # @return [String, String] the name of the Grom::Node or an empty string.
      def name
        respond_to?(:constituencyGroupName) ? constituencyGroupName : ''
      end

      # Alias constituencyGroupStartDate with fallback.
      #
      # @return [DateTime, nil] the start date of the Grom::Node or nil.
      def start_date
        @start_date ||= respond_to?(:constituencyGroupStartDate) ? DateTime.parse(constituencyGroupStartDate) : nil
      end

      # Alias constituencyGroupEndDate with fallback.
      #
      # @return [DateTime, nil] the end date of the Grom::Node or nil.
      def end_date
        @end_date ||= respond_to?(:constituencyGroupEndDate) ? DateTime.parse(constituencyGroupEndDate) : nil
      end

      # Alias constituencyGroupHasHouseSeat with fallback.
      #
      # @return [Array, Array] the house seats of the Grom::Node or an empty array.
      def seats
        respond_to?(:constituencyGroupHasHouseSeat) ? constituencyGroupHasHouseSeat : []
      end

      # Alias houseSeatHasSeatIncumbency with fallback.
      #
      # @return [Array, Array] the seat incumbencies of the Grom::Node or an empty array.
      def seat_incumbencies
        return @seat_incumbencies unless @seat_incumbencies.nil?

        seat_incumbencies = []
        seats.each do |seat|
          seat_incumbencies << seat.seat_incumbencies
        end

        @seat_incumbencies = seat_incumbencies.flatten.uniq
      end

      # Alias incumbencyHasMember with fallback.
      #
      # @return [Array, Array] the members of the Grom::Node or an empty array.
      def members
        return @members unless @members.nil?
        members = []
        seat_incumbencies.each do |seat_incumbency|
          members << seat_incumbency.member
        end

        @members = members.flatten.uniq
      end

      # Alias constituencyGroupHasConstituencyArea with fallback.
      #
      # @return [Grom::Node, nil] a Grom::Node with type http://id.ukpds.org/schema/ConstituencyArea or nil.
      def area
        respond_to?(:constituencyGroupHasConstituencyArea) ? constituencyGroupHasConstituencyArea.first : nil
      end

      # Alias incumbencyHasContactPoint with fallback.
      #
      # @return [Array, Array] the contact points of the Grom::Node or an empty array.
      def contact_points
        return @contact_points unless @contact_points.nil?

        contact_points = []
        seat_incumbencies.each do |seat_incumbency|
          contact_points << seat_incumbency.contact_points
        end

        @contact_points = contact_points.flatten.uniq
      end

      # Checks if Grom::Node has an end date.
      #
      # @return [Boolean] a boolean depending on whether or not the Grom::Node has an end date.
      def current?
        has_end_date = respond_to?(:constituencyGroupEndDate)

        !has_end_date
      end

      # Alias incumbencyHasMember with fallback.
      #
      # @return [Array, Array] the members of the Grom::Node is equivalent to one or an empty array.

      def member
        return @member unless @member.nil?
        member = []
        seat_incumbencies.each do |seat_incumbency|
          member << seat_incumbency.member
        end
        @member = member.flatten.uniq
      end

      def party_name
        return @constituency_node = @constituency_node.member.first.parties.first unless @constituency_node.nil?
        @constituency_node.respond_to?(:partyName) ? constituency_node.partyName : ''
      end
    end
  end
end
