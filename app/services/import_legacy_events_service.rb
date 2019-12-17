# frozen_string_literal: true

# Service to import Event data from legacy system.
class ImportLegacyEventsService
  # Initialize the service with a Zone and a list of Event data.
  def initialize(events = nil)
    @zone = Zone.default
    @events = events || FetchLegacyEventsService.new(@zone).call
  end

  # Do the thing.
  def call
    @events.map do |value|
      event = Event.find_or_initialize_by name: value['name']

      build_event event, value
      build_action event, value
      attach_image event, value
      finalize_event event, value

      event
    end
  end

  protected

  def build_event(event, value)
    event.assign_attributes(
      description: value['description'],
      starts_at: Time.at(value['starts'] / 1000),
      ends_at: Time.at(value['ends'] / 1000),
      splash_position: value['splash']['position']
    )
  end

  def build_action(event, value)
    event.assign_attributes(
      action_url: value['action']['url'],
      action_priority: value['action']['priority'],
      action_text: value['action']['text']
    )
  end

  def attach_image(event, value)
    return if value['image'].blank? || event.image.attached?

    begin
      image = URI.parse(value['image']).open
      event.image.attach io: image, filename: value['image']
    rescue OpenURI::HTTPError
      nil
    end
  end

  def finalize_event(event, value)
    update_stamp value['updated']
    event.save!
  end

  def update_stamp(stamp)
    return unless stamp && stamp > @zone.last_event_import

    @zone.last_event_import = stamp
    @zone.save!
  end
end
