class Movie < ActiveRecord::Base
  has_many :reviews
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true}
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future
  mount_uploader :image, ImageUploader

  def review_average
    if reviews.size > 0
    reviews.sum(:rating_out_of_ten)/reviews.size
    elsif !reviews.empty?
      reviews.rating_out_of_ten
    else
      "No reviews"
    end
  end

  def self.search(query)
    @movies = Movie.all
    @movies = @movies.where("title like ?", query[:title]) if query[:title].present?
    @movies = @movies.where("director like ?", query[:director]) if query[:director].present?
    if query[:duration].present? && query[:duration] == "90"
      @movies = @movies.where("runtime_in_minutes < ?" , query[:duration]) if query[:duration].present?
    elsif  query[:duration].present? && query[:duration] == "120"
      @movies = @movies.where("runtime_in_minutes > ?" , query[:duration]) if query[:duration].present?
    elsif  query[:duration].present? && query[:duration] == "100"
      @movies = @movies.where("runtime_in_minutes > ? AND runtime_in_minutes < ?" , 90, 120) if query[:duration].present?
    end
    return @movies
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date,"Should probably be in the future") if release_date < Date.today
    end
  end
end
