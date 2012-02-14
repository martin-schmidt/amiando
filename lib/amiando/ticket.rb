module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Users
  class Ticket < Resource

    ##
    # Get Ticket from id
    #
    # @param [Integer] the ticket id
    #
    # @return [Result] ticket data
    def self.ticket(id)
      object = Result.new
      get object, "/api/ticket/#{id}"
        
      object
    end

  end

end

