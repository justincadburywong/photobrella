require 'shrine'
require 'shrine/storage/s3'

s3_options = {
  # Required
  region: ENV['aws_region'],
  bucket: ENV['aws_bucket'],
  access_key_id: ENV['aws_access_key_id'],
  secret_access_key: ENV['aws_secret_access_key']
}

# URL options for CloudFront CDN
url_options = {
  public: true,
  host: URI.parse(URI.encode(ENV['aws_host']))
}

# The S3 storage plugin handles uploads to Amazon S3 service, using the aws-sdk gem.
Shrine.storages = {
  # With Shrine both temporary (:cache) and permanent (:store) storage are first-class citizens and fully configurable, so you can also have files cached on S3.
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: { acl: 'public-read' }, **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl: 'public-read' }, **s3_options)
}

# Plugins

# Provides ActiveRecord integration, adding callbacks and validations.
Shrine.plugin :activerecord
# Automatically logs processing, storing and deleting, with a configurable format.
Shrine.plugin :logging, logger: Rails.logger
# Allows you to specify default URL options for uploaded files.
Shrine.plugin :default_url_options, cache: url_options, store: url_options

# Backgrounding

# Adds the ability to put storing and deleting into a background job.
Shrine.plugin :backgrounding

# Setup background jobs (sidekiq workers) for async uploads.
# app/jobs/shrine_backgrounding/promote_job.rb
Shrine::Attacher.promote { |data| ShrineBackgrounding::PromoteJob.perform_async(data) }
# app/jobs/shrine_ba6ckgrounding/delete_job.rb
Shrine::Attacher.delete { |data| ShrineBackgrounding::DeleteJob.perform_async(data) }
