class RelationType < ActiveRecord::Migration
  def self.up
    add_column :relations, :type, :string
  end

  def self.down
    remove_column :relations, :type
  end
end
