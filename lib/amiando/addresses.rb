module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Addresses
  class Addresses < Resource

    ##
    # This request will return the billing address object of the user
    # with the specified internal id. The response contains all 
    # properties marked with R. If there hasn't been at least one 
    # update request to the billing address object, the error 
    # com.amiando.api.rest.ObjectNotFound will be returned.
    #
    # @param id the internal id of the user.
    #
    # @return [Result] saying if the update was sucessful     #TODO
    def self.billing(id)
      object = Result.new
      post object, "/api/user/#{id}/address/billing"

      object
    end

    ##
    # This request will return the buyer address object of the payment
    # with the specified internal id. The response contains all 
    # properties marked with R. The buyer address is the main payment
    # address associated with the ticket payment. It is required and
    # will be entered by the ticket buyer during the ticket purchase
    # process. It can later be updated by the event administrator.
    #
    # @param id id of the user
    #
    # @return [Partner] the partner with that id    #TODO
    def self.buyer(id)
      object = new
      get object, "/api/user/#{id}/address/buyer"

      object
    end

    ## 
    # This request will return the shipment address object of the
    # payment with the specified internal id. The response contains
    # all properties marked with R. If the ticket buyer wishes that
    # his paper tickets get shipped to a different address than the
    # buyer address, he can enter the shipment address during the
    # ticket purchase process. It is optional and only available if
    # the ticket buyer chooses paper tickets instead of e-tickets. It
    # can later be updated by the event administrator. If the payment
    # has no shipment address, the error
    # com.amiando.api.rest.ObjectNotFound will be returned.
    #   
    # @param id id of the user
    #   
    # @return [Partner] the partner with that id    #TODO
    def self.shipment(id)
      object = new 
      get object, "/api/user/#{id}/address/shipment"

      object
    end 


    private

    def populate(response_body)
      extract_attributes_from(response_body, 'addresses')
    end
  end
end
