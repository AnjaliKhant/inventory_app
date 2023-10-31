require 'faye/websocket'
require 'eventmachine'
require 'json'

class InventoryHandler
  def initialize
    @ws = Faye::WebSocket::Client.new('ws://localhost:8081/')
    @ws.on :message, &method(:handle_message)
  end

  def handle_message(event)
    data = JSON.parse(event.data)
    EventProcessor.process_event(data)
  end
end

EM.run { InventoryHandler.new }
