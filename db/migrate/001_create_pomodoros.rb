class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.column :who, :text
      t.column :failed, :boolean
    end
  end

  def self.down
    drop_table :pomodoros
  end
end
