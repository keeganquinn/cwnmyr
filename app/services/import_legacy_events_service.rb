# frozen_string_literal: true

# Service to import Event data from legacy system.
class ImportLegacyEventsService
  def initialize(events = nil)
    @events = events || FetchLegacyEventsService.new.call
  end

  def call
    @events.map do |value|
      event = Event.find_or_initialize_by name: value['name']

      build_event event, value
      attach_image event, value
      event.save!

      event
    end
  end

  def build_event(event, value)
    event.assign_attributes(
      description: value['description'],
      action_url: value['action']['url'],
      action_priority: value['action']['priority'],
      action_text: value['action']['text'],
      starts_at: Time.at(value['starts'] / 1000),
      ends_at: Time.at(value['ends'] / 1000),
      splash_position: value['splash']['position']
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
end
