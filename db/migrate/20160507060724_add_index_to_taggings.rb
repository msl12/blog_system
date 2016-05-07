class AddIndexToTaggings < ActiveRecord::Migration
  def change
  	add_index(:taggings, :tag_id, unique: true)
  	add_index(:taggings, :taggable_id, unique: true)
  	add_index(:taggings, :taggable_type, unique: true)
  	add_index(:taggings, :context, unique: true)
  	add_index(:taggings, :tagger_id, unique: true)
  	add_index(:taggings, :tagger_type, unique: true)
  end
end