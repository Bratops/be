class ChangedUgroupsAddedExdateExtimeGradeKlassNote < ActiveRecord::Migration
  def self.up
    add_column :ugroups, :exdate, :datetime
    add_column :ugroups, :extime, :integer
    add_column :ugroups, :grade, :integer
    add_column :ugroups, :klass, :integer
    add_column :ugroups, :note, :string
  end
  
  def self.down
    remove_column :ugroups, :exdate
    remove_column :ugroups, :extime
    remove_column :ugroups, :grade
    remove_column :ugroups, :klass
    remove_column :ugroups, :note
  end
end
