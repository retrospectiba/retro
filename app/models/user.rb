class User < ActiveRecord::Base
  attr_accessible :email, :logged_at, :name, :project, :password, :password_confirmation, :admin

  has_many :retrospectives

  has_and_belongs_to_many :invited_retrospectives,
                          :class_name => "Retrospective",
                          :join_table => "users_retrospectives",
                          :association_foreign_key => "retrospective_id"

  before_create :encrypt_password

  validates :email,    :presence =>true, :uniqueness=>true
  validates :name,     :presence =>true
  validates :project,  :presence =>true
  validates :password, :presence =>true, :length => { :minimum => 5, :maximum => 40 }, :confirmation => true
  validates_confirmation_of :password

  USER_PROJECTS = ["Core", "WebStore", "Aplicativos"]

  def self.md5(text)
    Digest::MD5.hexdigest(text)
  end

  def encrypt_password
    if password.present?
      self.password = Digest::MD5.hexdigest(self.password)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == md5(password)
      user
    end
  end

end
