include RandomData

#create posts
50.times do
  #use create! with a bang (!).
  #Adding a ! instructs the method to raise an error if there's a problem with the data being seeded.
  Post.create!(
  #use methods from a class that does not exist yet, RandomData, that will create random strings for title and body.
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph
  )
end
posts = Post.all

#Create comments
  #call times on an Integer (a number object). This will run a given block the specified number of times, which is 100 in this case.
  100.times do
    Comment.create!(
    #call sample on the array returned by Post.all, in order to pick a random post to associate each comment with. sample returns a random element from the array every time it's called.
    post: posts.sample,
    body: RandomData.random_paragraph
    )
  end

  50.times do
  Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: rand(1..1000))
  end

Advertisement.find_or_create_by(title: 'Do you want to advertise ads?', copy: 'It is the most rediculous job in the world', price: 1)

Post.find_or_create_by(title: 'This is my unique title.', body: 'This is the body of my unique post')

Comment.find_or_create_by(post_id: 'This is the comment on my unique post')



  puts "Seed finished"
  puts "#{Post.count} posts created"
  puts "#{Comment.count} comments created"
  puts "#{Advertisement.count} ads created"
