class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.string :nick
      t.text :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
