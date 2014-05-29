#Class that models a plain text document, complete with title and author:

# doc = Document.new('Hamlet','Shakespeare','To be or....')
# puts doc.title
# puts doc.author
# puts doc.content

# Document instances know how to parse their content into words:

# puts doc.words
# puts doc.word_count

class Document
  attr_accessor :writable
  attr_reader :title, :author, :content


  def title=( new_title )
    if @writable
      @title = new_title
    end
  end

  def author=( new_author )
    if @writable
      @author = new_author
    end
  end

  def content=( new_content )
    if @writable
      @content = new_content
    end
  end
 
  def words
    @content.split
  end

  def word_count
    words.size
  end
 
  # this function comes from http://www.sitepoint.com/natural-language-processing-ruby-n-grams/
  def ngrams(n, string)
    string.split(' ').each_cons(n).to_a
  end

  def same_author_probability( other_document)
    
    unigram_this = ngrams(1, @content)  
    unigram_other = ngram(1, other_document.content)
    
    bigram_this = ngrams(2, @content)
    bigram_other = ngrams(2, other_document.content)

    trigram_this = ngrams(3, @content)
    trigram_other = ngrams(3, other_document.content)

    uni_count = 0
    for word in unigram_this
      if unigram_other.include? word
        uni_count += 1
      end
    end
    
    bi_count = 0
    for words in bigram_this
      if bigram_other.include? words
        bi_count += 1
      end
    end

    tri_count = 0
    for words in trigram_this
      if trigram_other.include? words
        tri_count += 1
      end
    end

    similar_words = uni_count.to_f / unigram_this.length
    tmp_bi = bi_count.to_f / bigram_this.length
    tmp_tri = tri_count.to_f / trigram_this.length
    ave_phrasing_similarity = (tmp_bi + tmp_tri)/2.0
    report = [ 
         'The percentage of similar words between the two documents is #{similar_words}',
         'The average similarity between the phrases of the document is #{ave_phrasing_similarity}'
       ]

    end

    

end
  
