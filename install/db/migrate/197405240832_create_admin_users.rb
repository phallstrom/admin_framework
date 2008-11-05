class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :login
      t.string :password_hash
      t.string :name
      t.string :email
      t.boolean :is_enabled, :default => true
      t.boolean :is_superman, :default => false
      t.text :permissions
      t.timestamps
    end

    AdminUser.create(:login => 'philip', 
                     :password_hash => '9b67805e0a85d0f6ff444d3f53b6fe3640233c02', 
                     :name => 'Philip Hallstrom',
                     :email => 'philip@pjkh.com',
                     :is_enabled => true,
                     :is_superman => true)

    AdminUser.create(:login => 'admin', 
                     :password_hash => '4b4de5b821fbc8989dea6da5f9e95d83a33211ce', 
                     :name => 'Admin User',
                     :email => 'nobody@localhost',
                     :is_enabled => true,
                     :is_superman => true)
  end

  def self.down
    drop_table :admin_users
  end
end
