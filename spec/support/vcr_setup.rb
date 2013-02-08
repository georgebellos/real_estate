require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/vcr/cassettes'
  c.configure_rspec_metadata!
  c.default_cassette_options = { :re_record_interval => 7.days }
  c.ignore_localhost = true
end
