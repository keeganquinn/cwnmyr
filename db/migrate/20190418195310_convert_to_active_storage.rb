# frozen_string_literal: true

class ConvertToActiveStorage < ActiveRecord::Migration[5.2]
  require 'open-uri'

  def up
    prepare_statements
    Rails.application.eager_load!
    models = ActiveRecord::Base.descendants.reject(&:abstract_class?)

    transaction do
      models.each do |model|
        attachments = model.column_names.map do |c|
          Regexp.last_match(1) if c =~ /(.+)_file_name$/
        end.compact

        next if attachments.blank?

        model.find_each.each do |instance|
          attachments.each do |attachment|
            next if instance.send(attachment).path.blank?

            ActiveRecord::Base.connection.raw_connection.exec_prepared(
              'active_storage_blob_statement', [
                key(instance, attachment),
                instance.send("#{attachment}_file_name"),
                instance.send("#{attachment}_content_type"),
                instance.send("#{attachment}_file_size"),
                checksum(instance.send(attachment)),
                instance.updated_at.iso8601
              ]
            )

            ActiveRecord::Base.connection.raw_connection.exec_prepared(
              'active_storage_attachment_statement', [
                attachment,
                model.name,
                instance.id,
                instance.updated_at.iso8601
              ]
            )
          end
        end
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def prepare_statements
    get_blob_id = 'LASTVAL()'

    ActiveRecord::Base.connection.raw_connection.prepare(
      'active_storage_blob_statement', <<-SQL)
      INSERT INTO active_storage_blobs (
        key, filename, content_type, metadata, byte_size, checksum, created_at
      ) VALUES ($1, $2, $3, '{}', $4, $5, $6)
    SQL

    ActiveRecord::Base.connection.raw_connection.prepare(
      'active_storage_attachment_statement', <<-SQL)
      INSERT INTO active_storage_attachments (
        name, record_type, record_id, blob_id, created_at
      ) VALUES ($1, $2, $3, #{get_blob_id}, $4)
    SQL
  end

  def key(instance, attachment)
    instance.send("#{attachment}_file_name")
  end

  def checksum(attachment)
    attached_file = attachment.to_file
    Digest::MD5.base64digest(attached_file.read)
    attached_file.unlink
  end
end
