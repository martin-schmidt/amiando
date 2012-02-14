module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Users
  class Payment < Resource

    ##
    # Get Tickets from Payment
    #
    # @param [Integer] ticketID
    #
    # @raise [StandardError] if success isn't true
    # @return [Result] with an array of ids
    def self.tickets(payment_id)
      object = Result.new { |response_body| response_body['tickets'] }
      get object, "/api/payment/#{id}/tickets"
        
      object
    end

  end

end

