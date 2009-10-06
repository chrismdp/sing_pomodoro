class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.column :who, :text
      t.column :started_at, :datetime
      t.column :finished_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :pomodoros
  end
end
