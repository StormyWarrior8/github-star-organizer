class AddSyncJobIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sync_job_id, :string
  end
end
