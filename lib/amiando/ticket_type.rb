module Amiando
  class TicketType < Resource

    ##
    # Create a ticket type for an event
    #
    # @param event_id
    # @param type string or symbol of the following:
    #   * TICKETTYPE_ETICKET
    #   * TICKETTYPE_PAPER
    #   * TICKETTYPE_BADGE
    #   * TICKETTYPE_CONFIRMATION
    #   * TICKETTYPE_ONSITE
    #
    #   It will also accept :eticket, :paper, :badge, :confirmation, :onsite
    #
    def self.create(event_id, type)
      type = type[:type] if type.is_a?(Hash)

      unless type =~ /^tickettype_\w+/i
        type = "tickettype_#{type}"
      end

      object = Result.new do |response_body, result|
        result.errors = response_body['errors']
        response_body['id'] || false
      end

      post object, "api/event/#{event_id}/ticketType/create", :params => { :type => type.upcase }

      object
    end

    ##
    # Find all Payment Types of an event
    #
    # @param event_id
    #
    # @return [Result] with the list of payment types for that event.
    def self.find_all_by_event_id(event_id)
      object = Result.new do |response_body, result|
        if response_body['success']
          response_body['results']['paymentTypes'].map do |payment_type|
            new(payment_type)
          end
        else
          result.errors = response_body['errors']
          false
        end
      end

      get object, "api/event/#{event_id}/paymentTypes"

      object
    end

    ##
    # Find a Payment Type
    #
    # @param payment_type_id
    #
    # @return [PaymentType] the payment type with that id
    def self.find(payment_type_id)
      object = new
      get object, "api/paymentType/#{payment_type_id}"

      object
    end

    ##
    # Update a payment type
    #
    # @param payment_type_id
    # @param [Hash] attributes attributes to be updated
    #
    # @return [Boolean] result of the operation
    def self.update(payment_type_id, attributes)
      object = Boolean.new('success')
      post object, "api/paymentType/#{payment_type_id}", :params => attributes

      object
    end

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'paymentType')
    end
  end
end

