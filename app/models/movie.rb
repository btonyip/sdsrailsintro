class Movie < ActiveRecord::Base
  attr_reader :all_ratings

  def self.all_ratings 
    #initialising the all_ratings 
    #(cannot use initialise because Rails already have its own initialise framework, 
    #do not override it)
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    if ratings_list == []
      all
    else
      where(rating: ratings_list)
    end
  end

  def self.ratings_to_show_hash(rating)
    #checking the parameter ratings, if there is no ratings return empty array
    #else since parameter is in a dictionary, return the keys of the dictionary
    #ratings should be in {"PG-13"=>"1", "PG"=>"1"} 
    if rating == nil
      return []
    elsif rating.is_a?(Array)
      return rating
    else
      return rating.keys
    end
  end

  def self.column_sort(sort)
    if sort == nil
      return nil
    else
      return sort.keys
    end
  end

  def self.sort_with_ratings(rating, sort)
    if sort == nil
      self.with_ratings(rating)
    
    elsif
      sort == ["title"]
      data = self.with_ratings(rating)
      return data.order(:title)
    
    elsif sort == ["date"]
      data = self.with_ratings(rating)
      return data.order(release_date: :asc)
      
    end
  end


end
