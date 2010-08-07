# To change this template, choose Tools | Templates
# and open the template in the editor.

class LanguagesLogical < AbstractLogical
  def initialize
    
  end

  def save_language(word, category, parse)
    @language = Language.find(:first, :conditions=>["word=? and category=?", word,category])
    if (@language ==nil)
       @language = Language.new
       @language.count=1
       @language.word=word
       @language.parse=parse
       @language.category=category
    else
     count= @language.count
     @language.count=count + 1
    end
    return @language
  end
end
