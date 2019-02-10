# frozen_string_literal: true

xml.instruct!

xml.rdf :RDF,
        'xmlns:rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
        'xmlns:rdfs': 'http://www.w3.org/2000/01/rdf-schema#',
        'xmlns:foaf': 'http://xmlns.com/foaf/0.1/',
        'xmlns:admin': 'http://webns.net/mvcb/' do
  xml.foaf :PersonalProfileDocument, 'rdf:about': '' do
    xml.foaf :maker, 'rdf:resource': '#me'
    xml.foaf :primaryTopic, 'rdf:resource': '#me'
    xml.admin :generatorAgent, 'rdf:resource': root_url
    xml.admin :errorReportsTo,
              'rdf:resource': 'https://github.com/keeganquinn/cwnmyr'
  end

  xml.foaf :Person, 'rdf:ID': 'me' do
    xml.foaf :name, @user.name
  end
end
