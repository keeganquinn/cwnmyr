# frozen_string_literal: true

json.type 'events'
json.apiVersion '0.1.1'
json.time((Time.now.to_f * 1000.0).to_i)

json.data @events do |event|
  json.name event.name
  json.description event.description
  json.action do
    json.url event.action_url
    json.priority event.action_priority
    json.text event.action_text
  end
  json.starts((event.starts_at.to_f * 1000.0).to_i) if event.starts_at.present?
  json.ends((event.ends_at.to_f * 1000.0).to_i) if event.ends_at.present?
  json.image event_path(event, format: :jpg) if event.image.attached?
  json.splash do
    json.position event.splash_position
  end
  json.id event.id&.to_s
  json.updated((event.updated_at.to_f * 1000.0).to_i)
end
