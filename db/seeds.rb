include RandomData

#Create Users
5.times do
  user = User.create!(
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all 

#create topics
15.times do
  Topic.create!(
  name:          RandomData.random_sentence,
  description:   RandomData.random_paragraph
  )
 end
 topics = Topic.all

#create posts
50.times do
  #use create! with a bang (!).
  #Adding a ! instructs the method to raise an error if there's a problem with the data being seeded.
  Post.create!(
  #use methods from a class that does not exist yet, RandomData, that will create random strings for title and body.
    user: users.sample,
    topic: topics.sample,
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

  #create ads
  50.times do
  Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: rand(1..1000))
  end

  #create  questions
  50.times do
  Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: rand(0..1))
end

  #create sponsored posts
  10.times do
    SponsoredPost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..25))
  end

SponsoredPost.find_or_create_by(title: 'I would like one billion dollars', body: 'I think I deserve it.', price: 1000000000)

Topic.find_or_create_by(name: 'The most great topic', description: 'To describe this topic would be redundant')

Question.find_or_create_by(title: 'I have the perfect question', body: 'why?', resolved: 1)

Advertisement.find_or_create_by(title: 'Do you want to advertise ads?', copy: 'It is the most rediculous job in the world', price: 1)

Post.find_or_create_by(title: 'This is my unique title.', body: 'This is the body of my unique post')

Comment.find_or_create_by(post_id: 'This is the comment on my unique post')

user = User.first
 user.update_attributes!(
   email: 'jmalis@live.com',
   password: 'helloworld'
 )



  puts "Seed finished"
  puts "#{User.count} users created"
  puts "#{Topic.count} topics created"
  puts "#{Post.count} posts created"
  puts "#{Comment.count} comments created"
  puts "#{Advertisement.count} ads created"
  puts "#{SponsoredPost.count} sponsored posts created"
  puts "#{Question.count} questions created"
