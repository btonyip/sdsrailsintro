module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def headercolour(column_name)
     if @column_sorting == nil
      ""
     elsif column_name == @column_sorting.first
      'hilite bg-warning'
     else
      ""
     end
   end

  
end
