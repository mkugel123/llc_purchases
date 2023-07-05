# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'net/http'
require 'json'

master_url = "https://data.cityofnewyork.us/resource/bnx9-e6tj.json?doc_type=DEED&$select=document_id,document_date&$where= document_date IS NOT NULL AND document_amt > 1000&$order=document_date DESC&$limit=30"
master_uri = URI.parse(master_url)
master_response = Net::HTTP.get_response(master_uri)
master_results = JSON.parse(master_response.body)
master_ids = master_results.map { |hash| hash['document_id'] }

puts master_results


legals_url = "https://data.cityofnewyork.us/resource/8h5j-fqxa.json?$query=SELECT document_id,street_number,street_name WHERE document_id IN ('#{master_ids.join("', '")}') AND borough = 3"
legals_uri = URI.parse(legals_url)
legals_response = Net::HTTP.get_response(legals_uri)
legals_results = JSON.parse(legals_response.body)
legals_ids = legals_results.map { |hash| hash['document_id'] }

puts legals_results

parties_url = "https://data.cityofnewyork.us/resource/636b-3b5g.json?$query=SELECT name, address_1, address_2, document_id WHERE document_id IN ('#{legals_ids.join("', '")}') AND party_type = '2' AND name LIKE '%25LLC'"
parties_uri = URI.parse(parties_url)
parties_response = Net::HTTP.get_response(parties_uri)
parties_results = JSON.parse(parties_response.body)
parties_ids = parties_results.map { |hash| hash['document_id'] }


parties_results.each do |r|
  corresponding_master = master_results.find {|x| x['document_id'] == r['document_id']}
  corresponding_legal = legals_results.find {|x| x['document_id'] == r['document_id']}

  Property.create(document_id: r['document_id'].to_i, owner: r['name'], owner_address_1: r['address_1'], owner_address_2: r['address_2'], property_street_name: corresponding_legal['street_name'], property_street_number: corresponding_legal['street_number'], date_on_deed: corresponding_master['document_date'][0,10])
end

