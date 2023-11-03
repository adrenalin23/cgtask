class Prompt < ApplicationRecord
    include ::Elasticsearch::Model
    include ::Elasticsearch::Model::Callbacks
  
    index_name "prompts-#{Rails.env}"
    document_type "prompts"

    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do
            indexes :text, type: 'text'
        end
    end

    def as_indexed_json(options={})
        self.as_json(only: [:text])
    end
end