class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :board_state
      t.string :turn

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
