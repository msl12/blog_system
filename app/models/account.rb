require 'base64'

class Account < ActiveRecord::Base
	attr_accessor :password # 虚拟属性
	has_many :blogs

	validates_presence_of :email, :if => :password_required
	validates_presence_of :password, :if => :password_required
	validates_uniqueness_of :email, :case_sensitive => false, :if => :password_required
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => :password_required

	before_save :encrypt_password, :if => :password_required

	def self.authenticate(email, password)
		account=Account.find_by_email(email) if email.present?
		account && account.has_password?(password) ? account : nil
	end

	def admin?
		self.email=='2496227361@qq.com'
	end

	def has_password?(password)
		::BCrypt::Password.new(crypted_password)==password
	end

	private
	def encrypt_password
		self.crypted_password=::BCrypt::Password.create(password) unless password.blank?
	end

	def password_required
		crypted_password.blank? || password.present?
	end

end