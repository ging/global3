class ActorForeignKey < ActiveRecord::Migration
  def self.up
    add_column :actors, :subject_id, :integer
    add_column :actors, :subject_type, :string
    add_index :actors, [ "subject_id", "subject_type" ], :unique => true
    remove_index :users, :name => 'fk_user_actor'
    remove_column :users, :actor_id
    remove_index :spaces, :name => 'fk_espacio_actor'
    remove_column :spaces, :actor_id
  end

  def self.down
    remove_index :actors, [ "subject_id", "subject_type" ]
    remove_column :actors, :subject_id
    remove_column :actors, :subject_type
    add_column :users, :actor_id, :integer
    add_index :users, :actor_id, :name => "fk_user_actor"

    add_column :spaces, :actor_id, :integer
    add_index :spaces, :actor_id, :name => "fk_espacio_actor"
  end
end
