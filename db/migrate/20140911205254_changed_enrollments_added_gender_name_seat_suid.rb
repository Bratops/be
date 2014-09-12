class ChangedEnrollmentsAddedGenderNameSeatSuid < ActiveRecord::Migration
  def self.up
    add_column :enrollments, :gender, :integer
    add_column :enrollments, :name, :string
    add_column :enrollments, :seat, :integer, :default=>nil
    add_column :enrollments, :suid, :string
  end
  
  def self.down
    remove_column :enrollments, :gender
    remove_column :enrollments, :name
    remove_column :enrollments, :seat
    remove_column :enrollments, :suid
  end
end
