class AddIndexToTaggings < ActiveRecord::Migration
  def change
  	add_index(:taggings, :tag_id)
  	add_index(:taggings, :taggable_id)
  	add_index(:taggings, :taggable_type)
  	add_index(:taggings, :context)
  	add_index(:taggings, :tagger_id)
  	add_index(:taggings, :tagger_type)
  end
end