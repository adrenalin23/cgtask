require 'httparty'

namespace :data do
  desc 'Import data from a remote source to your database and Elasticsearch'

  task import: :environment do
    offset = 0
    limit = 1000

    while true do
      url = "https://datasets-server.huggingface.co/rows?dataset=Gustavosta%2FStable-Diffusion-Prompts&config=default&split=train&offset=#{offset}&limit=#{limit}"
      response = HTTParty.get(url)

      break if response['rows'].length == 0

      response['rows'].each do |row|
        ::Prompt.create(text: row['row']['Prompt'])
      end

      offset += limit
    end

    # Index the data in Elasticsearch at the end
    ::Prompt.import

    puts 'Data import and indexing completed.'
  end
end
