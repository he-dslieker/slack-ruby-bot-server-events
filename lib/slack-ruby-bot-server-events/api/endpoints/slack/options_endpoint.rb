# frozen_string_literal: true

require 'json'

module SlackRubyBotServer
  module Events
    module Api
      module Endpoints
        module Slack
          class EventsEndpoint < Grape::API
            desc 'Handle Slack options requests.'
            params do
              requires :payload, type: JSON
            end
            post '/options' do
              status 200

              event = SlackRubyBotServer::Events::Requests::Event.new(params[:payload], request)

              type = event[:type]
              block_id = event[:block_id]
              key = [type, block_id].compact

              SlackRubyBotServer::Events.config.run_callbacks(:options, key, event) || body(false)
            end
          end
        end
      end
    end
  end
end
