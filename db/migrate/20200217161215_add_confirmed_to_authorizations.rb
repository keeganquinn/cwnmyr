class AddConfirmedToAuthorizations < ActiveRecord::Migration[6.0]
  def change
    add_column :authorizations, :confirmed_at, :datetime

    Authorization.all.each do |authorization|
      authorization.confirmed_at = authorization.created_at
      authorization.save!
    end

    User.where.not(hostmask: [nil, '']).each do |user|
      user.authorizations.create! provider: 'cinch',
                                  uid: user.hostmask,
                                  confirmed_at: user.hostmask_confirmed_at
    end

    remove_column :users, :hostmask
    remove_column :users, :hostmask_confirmed_at
    remove_column :users, :unconfirmed_hostmask
  end
end
