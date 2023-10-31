# In your initializer
require_relative '../../app/services/inventory_event_handler'

EM.run { InventoryEventHandler.new }
