class CandidatesResults < ActiveRecord::Migration
  def self.up
    create_table :candidates_results, :id => false do |t|
      t.integer :candidate_id
      t.integer :result_id
    end
  end

  def self.down
    drop_table :candidates_results
  end
end