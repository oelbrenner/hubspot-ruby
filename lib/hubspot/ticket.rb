module Hubspot
  #
  # HubSpot Ticket API
  #
  # {https://developers.hubspot.com/docs/methods/tickets/tickets-overview}
  #
  #
  class Ticket
    TICKETS_PATH       = '/crm-objects/v1/objects/tickets' 
    TICKET_PATH        = '/crm-objects/v1/objects/tickets/:form_guid'

    class << self
      # {https://developers.hubspot.com/docs/methods/tickets/create-ticket}
      # required: hs_pipeline, hs_pipeline_stage
      def create!(opts={})
        response = Hubspot::Connection.post_json(TICKETS_PATH, params: {}, body: opts)
        puts "response: #{response}"
        new(response)
      end

      # {https://developers.hubspot.com/docs/methods/tickets/get_ticket_by_id}
      def find(guid)
        puts "guid: #{guid}"
        # specifically ask for extended properties
        response = Hubspot::Connection.get_json(TICKET_PATH, { form_guid: guid, properties: ['subject', 'content', 'hs_pipeline', 'hs_pipeline_stage'] })
        new(response)
      end
    end

    attr_reader :guid
    attr_reader :properties

    def initialize(hash)
      self.send(:assign_properties, hash)
    end

    private

    def assign_properties(hash)
      @guid = hash['guid']
      @properties = hash
    end

  end
end
