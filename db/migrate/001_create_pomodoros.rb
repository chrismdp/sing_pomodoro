class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.column :who, :text
      t.column :started_at, :int
      t.column :finished_at, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :pomodoros
  end
end
