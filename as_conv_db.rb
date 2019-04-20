#!bin/rails runner

# frozen_string_literal: true

ActiveStorage::Attachment.find_each do |attachment|
  name = attachment.name

  attached_file = attachment.record.send(name).to_file
  source = attached_file.path
  dest_dir = File.join(
    'storage',
    attachment.blob.key.first(2),
    attachment.blob.key.first(4).last(2)
  )
  dest = File.join(dest_dir, attachment.blob.key)

  FileUtils.mkdir_p(dest_dir)
  puts "Moving #{source} to #{dest}"
  FileUtils.cp(source, dest)
  attached_file.unlink
end
