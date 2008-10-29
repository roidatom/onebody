class AddRevampGroupMemberships < ActiveRecord::Migration
  def self.up
    remove_column :groups, :cached_parents
    add_column :memberships, :auto, :boolean, :default => false
    Site.each do
      Membership.all.each do |membership|
        if membership.group.linked? or membership.group.parents_of
          membership.update_attributes! :auto => true
        end
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, 'Cannot revert this migration.'
  end
end
