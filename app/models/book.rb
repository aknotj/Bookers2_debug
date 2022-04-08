class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end



  def self.search_for(content, method)
    if method == "exact"
      Book.where(title: content)
    elsif method == "foward"
      Book.where("title like ?", content + "%")
    elsif method == "backward"
      Book.where("title like ?", "%" + content)
    else
      Book.where("title like ?", "%" + content.to_s + "%")
    end
  end

end
