class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable


  has_many :messages, :foreign_key => "to_id"
  has_many :sent_messages, :foreign_key => "from_id", :class_name => "Message"
  has_many :reviews
  has_one :company
  has_many :articles, :foreign_key => "author_id"
  has_many :projects

  image_accessor :image
  attr_accessible :name, :email, :description, :image, :password, :password_confirmation,
                  :remember_me, :provider, :uid, :confirmed_at, :author

  validates_presence_of :name
  validates_presence_of :email

  def name
    [self.first_name, self.last_name].join(' ').strip()
  end

  def name=(name)
    tokens = name.strip.split(/\s+/)
    self.first_name = self.last_name = nil

    self.first_name = tokens[0].titleize if tokens[0] and tokens[0] =~ /[A-Za-z]+/
    self.last_name = tokens[1].titleize if tokens[1] and tokens[1] =~ /[A-Za-z]+/
  end

  def has_company?
    company
  end

  def is_author_of? article
    articles.include?(article)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(:name => auth.extra.raw_info.name,
                         :provider => auth.provider,
                         :uid => auth.uid,
                         :email => auth.info.email,
                         :password => Devise.friendly_token[0,20],
                         :confirmed_at => DateTime.now
      )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
