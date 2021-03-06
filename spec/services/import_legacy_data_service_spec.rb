# frozen_string_literal: true

describe ImportLegacyDataService do
  subject(:service) { described_class }

  before do
    create :zone, default: true
    create :user, :admin
    create :status, code: 'active'
    create :status, code: 'retired'
  end

  node_data = [
    {
      'node' => 'Spec',
      'nodename' => 'Spec Node',
      'status' => 'active',
      'description' => 'Spec Node For Testing Stuff',
      'address' => '709 W 27th St., Vancouver, WA 98660',
      'logo' => 'LuckyLabNW.png',
      'contact' => 'Some McGuy',
      'email' => 'some@guy.net',
      'phone' => '123-456-7890',
      'role' => 'happened to be nearby',
      'url' => 'https://node.guy.net/',
      'rss' => 'https://node.guy.net/feed.xml',
      'twitter' => 'someguyontwitter',
      'wikiurl' => 'https://personaltelco.net/wiki/NodeSomeGuy',
      'hostname' => 'some',
      'device' => 'mr3201a',
      'filter' => 'true',
      'splashpageversion' => 'yes',
      'dhcpstart' => '10',
      'pubaddr' => '10.11.23.1',
      'pubmasklen' => '24',
      'privaddr' => '192.168.0.1',
      'privmasklen' => '24',
      'updated' => 12_345
    }, {
      'node' => 'BadLogoSpec',
      'nodename' => 'Spec Node With Broken Logo Link',
      'status' => 'active',
      'description' => 'Gets imported even though the logo is a 404',
      'logo' => 'InvalidLogoPath.png'
    }, {
      'node' => 'Klickitat',
      'nodename' => 'Node with specific references should exist',
      'status' => 'retired',
      'updated' => 12_347
    }, {
      'node' => 'TestSomething',
      'nodename' => 'Test devices should be linked to Klickitat',
      'status' => 'active'
    }
  ].freeze

  let!(:nodes) { service.new(node_data).call }

  xit 'returns nodes' do
    expect(nodes).not_to be_empty
  end

  xit 'creates node records' do
    expect(Node.count).to be_positive
  end

  xit 'creates contact records' do
    expect(Contact.count).to be_positive
  end

  xit 'creates device records' do
    expect(Device.count).to be_positive
  end

  xit 'creates device property records' do
    expect(DeviceProperty.count).to be_positive
  end

  xit 'creates interface records' do
    expect(Interface.count).to be_positive
  end
end
