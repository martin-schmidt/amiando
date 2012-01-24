require 'test_helper'

describe Amiando::TicketType do
  before do
    HydraCache.prefix = 'TicketType'
  end

  after do
    HydraCache.prefix = nil
  end

  let(:event) { Amiando::Factory.create(:event) }

  describe 'create' do
    it 'creates a ticket type given valid attributes' do
      payment_type = Amiando::TicketType.create(event.id, :eticket)

      Amiando.run

      payment_type.result.wont_be_nil
    end

    it 'handles errors properly' do
      payment_type = Amiando::TicketType.create(event.id, :lalala)
      Amiando.run

      payment_type.result.must_equal false
      payment_type.errors.must_include "com.amiando.api.rest.InvalidParam"
    end

    it 'should accept a Hash as a param' do
      payment_type = Amiando::TicketType.create(event.id, :type => :eticket)
      payment_type.request.params.must_equal(:type => "TICKETTYPE_ETICKET")
    end

    it 'should accept a type string as a param' do
      payment_type = Amiando::TicketType.create(event.id, :type => "TICKETTYPE_ETICKET")
      payment_type.request.params.must_equal(:type => "TICKETTYPE_ETICKET")
    end

    it 'should accept a short string as a param' do
      payment_type = Amiando::TicketType.create(event.id, "ETICKET")
      payment_type.request.params.must_equal(:type => "TICKETTYPE_ETICKET")
    end
  end

  # describe 'find' do
  #   it 'finds a payment type given the id' do
  #     payment_id = Amiando::TicketType.sync_create(event.id, :invoice).result

  #     payment = Amiando::TicketType.find(payment_id)
  #     Amiando.run

  #     payment.id.must_equal payment_id
  #   end
  # end

  # describe 'find_all_by_event_id' do
  #   it 'finds the payment types given an event' do
  #     payment_id = Amiando::TicketType.sync_create(event.id, :invoice).result
  #     payment_type = Amiando::TicketType.sync_find(payment_id)

  #     payment_types = Amiando::TicketType.find_all_by_event_id(event.id)
  #     Amiando.run

  #     payment_types.result.must_include payment_type
  #   end
  # end

  # describe 'update' do
  #   it 'updates the given attributes' do
  #     event = Amiando::Factory.create(:event, :name => "event-update-#{HydraCache.revision}")
  #     payment_id = Amiando::TicketType.sync_create(event.id, :invoice).result
  #     update = Amiando::TicketType.update(payment_id, :active => false)
  #     Amiando.run

  #     update.result.must_equal true

  #     payment_type = Amiando::TicketType.sync_find(payment_id)
  #     payment_type.active.must_equal false
  #   end
  # end

  # describe 'type' do
  #   it 'returns the amiando type string' do
  #     payment_type = Amiando::TicketType.new(:type => 'PAYMENT_TYPE_PP')
  #     payment_type.type.must_equal 'PAYMENT_TYPE_PP'
  #   end
  # end

end
