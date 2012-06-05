module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Users
  class Payment < Resource

    ##
    # Fetch a payment
    #
    # @param [Integer] the payments id
    # 
    # @return [Result] with the Payment
    def self.find(id)
      object = Result.new { |response_body| response_body['tickets'] }
      get object, "/api/payment/#{id}"

      object
    end

    ##
    # Get Tickets from Payment
    #
    # @param [Integer] the payments id
    #
    # @return [Result] with an array of ids
    def self.tickets(id)
      object = Result.new { |response_body| response_body['tickets'] }
      get object, "/api/payment/#{id}/tickets"
        
      object
    end

  end

end

