class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  has_many :view_counts, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_two_days_ago, -> { where(created_at: 2.day.ago.all_day) } #2日前
  scope :created_three_days_ago, -> { where(created_at: 3.day.ago.all_day) } #3日前
  scope :created_four_days_ago, -> { where(created_at: 4.day.ago.all_day) } #4日前
  scope :created_five_days_ago, -> { where(created_at: 5.day.ago.all_day) } #5日前
  scope :created_six_days_ago, -> { where(created_at: 6.day.ago.all_day) } #6日前
  
  scope :created_this_week, -> {where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }
  scope :created_last_week, -> {where(created_at: ((Time.current.at_end_of_day - 14.day).at_beginning_of_day)..(Time.current.at_end_of_day - 6.day)) }

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
