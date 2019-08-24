# frozen_string_literal: true

Premailer::Rails.config.merge!(
  generate_text_part: false, preserve_styles: true, remove_ids: true
)
