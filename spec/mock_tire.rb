require 'tire'

module Tire
  module Disable
    module ClassMethods
      def mock_es_response_doc
        @mock_es_response_doc ||=
          '{"took": 1,"timed_out": false,"_shards": {"total": 5,"successful": 5,"failed": 0},"hits": {"total": 0,"max_score": null,"hits": []}}'
      end

      def enable! &blk
        old_enabled = @tire_enabled || false
        @tire_enabled = true
        WebMock.disable!
        if block_given?
          begin
            yield
          ensure
            @tire_enabled = old_enabled
            if not @tire_enabled
              self.disable!
            end
          end
        end
      end

      def disable!
        WebMock.enable! && WebMock.reset!
        WebMock
        .stub_request(:any, %r|#{Tire::Configuration.url}.*|)
        .to_return(status: 200, body: mock_es_response_doc, headers: {})
      end

      def init_elasticsearch_index klass
        idx = Tire::Index.new klass.tire.index.name
        idx.delete
        idx.create mappings: klass.tire.mapping_to_hash, settings: klass.tire.settings
        idx.refresh
      end
    end
  end
  extend Disable::ClassMethods
end
