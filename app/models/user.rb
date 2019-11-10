class User < ApplicationRecord

  has_many :microposts,dependent: :destroy
  #Filter method to transform email to small cases before saving to db 
  before_save{email.downcase!}  #dall letters be small

  validates :name,presence:true,length:{maximum:50}

  # REGEX = Regular Expression
  #To variable correct email structure
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence:true,length:{maximum:50},
                                 format:{with: EMAIL_REGEX},
                                 uniqueness: {case_sensitive: false} #big or small letter no matter
  has_secure_password
  validates :password,length: {minimum:6},allow_nil:true

  has_many :active_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following,through: :active_relationships, source: :followed
  has_many :followers,through: :passive_relationships, source: :follower
            
  #follow a user
  def follow(other_user)
    active_relationships.create(followed_id:other_user.id)
  end

  #unfollows a user
  def unfollow(other_user)
    active_relationships.create(followed_id:other_user.id).destroy
  end

  #Returs true if the curent user is following the other user.
  def folowing?(other_user)
    following.includes?(other_user)
  end
                                                         
end
