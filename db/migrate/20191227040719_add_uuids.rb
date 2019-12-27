class AddUuids < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :uuid, :uuid
    Contact.all.each do |contact|
      contact.set_defaults
      contact.save!
    end

    add_column :devices, :uuid, :uuid
    Device.all.each do |device|
      device.set_defaults
      device.save!
    end

    add_column :events, :uuid, :uuid
    Event.all.each do |event|
      event.set_defaults
      event.save!
    end

    add_column :groups, :uuid, :uuid
    Group.all.each do |group|
      group.set_defaults
      group.save!
    end

    add_column :interfaces, :uuid, :uuid
    Interface.where(device_id: nil).delete_all
    Interface.all.each do |interface|
      unless interface.device.present?
        interface.destroy
        next
      end

      interface.set_defaults
      interface.save!
    end

    add_column :networks, :uuid, :uuid
    Network.all.each do |network|
      network.set_defaults
      network.save!
    end

    add_column :nodes, :uuid, :uuid
    Node.all.each do |node|
      node.set_defaults
      node.save!
    end

    add_column :statuses, :uuid, :uuid
    Status.all.each do |status|
      status.set_defaults
      status.save!
    end

    add_column :users, :uuid, :uuid
    User.all.each do |user|
      user.set_defaults
      user.save!
    end

    add_column :zones, :uuid, :uuid
    Zone.all.each do |zone|
      zone.set_defaults
      zone.save!
    end
  end
end
