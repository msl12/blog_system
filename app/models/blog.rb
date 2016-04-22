class Blog < ActiveRecord::Base
	belongs_to :blog_content, :dependent => :destroy
	belongs_to :account

	validates :title, :presence => true
	validates :title, :length => {:in => 3..50}

	 delegate :content, :to => :blog_content, :allow_nil => true # 这个地方不是很熟
end