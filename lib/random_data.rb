#define RandomData as a module because it is a standalone library with no dependencies or inheritance requirements.
#Modules help keep common functions organized and reusable throughout our application.
module RandomData

  def self.random_name
     first_name = random_word.capitalize
     last_name = random_word.capitalize
     "#{first_name} #{last_name}"
   end

   def self.random_email
     "#{random_word}@#{random_word}.#{random_word}"
   end

#define random_paragraph. We set sentences to an array. We create four to six random sentences and append them to sentences.
#We call join on sentences to combine each sentence in the array, passing a space () which will separate each sentence. join combines each sentence into a full paragraph (as a string).
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end

    sentences.join(" ")
    end

#follow the same pattern as we did in #6 to create a sentence with a random number of words. After a sentence is generated, we call capitalize on it and append a period.
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

#we define random_word. We set letters to an array of the letters a through z using to_a. We call shuffle! on letters in place.
#If we were to call shuffle without the bang(!), then shuffle would return an array rather than shuffle in place. We join the zeroth through nth item in letters.
#The nth item is the result of rand(3..8) which returns a random number greater than or equal to one and less than or equal to eight.
  def self.random_word
    letters = ("a".."z").to_a
    letters.shuffle!
    letters[0,rand(6..8)].join
  end
end
