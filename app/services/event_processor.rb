# app/services/event_processor.rb
class EventProcessor
  BATCH_SIZE = 10

  # Create an empty event buffer
  @@event_buffer = []

  # This method processes an event and adds it to the event buffer
  def self.process_event(data)
    @@event_buffer << data

    # If the event buffer reaches BATCH_SIZE, save the batch
    save_batch if @@event_buffer.length >= BATCH_SIZE
  end

  # Save a batch of events to the database
  def self.save_batch
    ActiveRecord::Base.transaction do
      @@event_buffer.each do |event|
        store = Store.find_or_create_by(name: event['store'])
        shoe = Shoe.find_or_create_by(name: event['model'])

        Inventory.create(
          store: store,
          shoe: shoe,
          inventory_count: event['inventory']
        )
      end
    end

    # Clear the event buffer
    @@event_buffer.clear
  end
end

  