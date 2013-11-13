require 'pry'

def first_question
  puts "Would you like to start a new session?"
  answer = gets.chomp.downcase
 
  if answer == "yes"
    new_session
  else
    puts "Ok. Would you like to review a previous session?"
    prev_session = gets.chomp.downcase
    if prev_session == "yes"
      list_tracks
      puts "Which session would you like to review (select the id)?"
      choice = gets.chomp.to_i
      choice = choice - 1
      sessions = find_tracks
      choice = sessions [choice]
      distractions = File.read ("./tracks/#{choice}")
      puts "You had #{distractions} distractions in that session"
      #GET AND REVIEW PREVIOUS SESSIONS
    elsif prev_session == "no"
      puts "Well if you don't want a new session, and you don't want to review your old sessions, then you're SOL."
    else
      puts "That's not an acceptable response. Yes or no, chief."
      first_question
    end
  end
end
 
def new_session
  distractions = 0
  puts "How many times have you been distracted in this session?"
  distractions += gets.chomp.to_i
  puts "You have #{distractions} tracks."
  puts "Would you like to continue this session?"
  continue = gets.chomp.downcase
  while continue == "yes" do
    puts "How many tracks would you like to add?"
    distractions += gets.chomp.to_i
    puts "You now have #{distractions} distractions. Would you like to continue?"
    continue = gets.chomp.downcase
  end

  pretty_time = Time.now.strftime('%Y-%m-%d-%H%M%S')
 
  File.open("./tracks/session-#{pretty_time}.track", 'w') do |file|
    file.write(distractions)
  end
end

def find_tracks
  sessions = Dir.entries("./tracks")
  sessions.find_all do |file|
    file.match(/\A[^\.]/)
  end
end
def list_tracks
  find_tracks.each_with_index do |session, index|
    puts "#{index+1}. #{session}"
  end
end
 
first_question