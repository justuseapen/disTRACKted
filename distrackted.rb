def first_question
  puts "Would you like to start a new session?"
  answer = gets.chomp.downcase

  if answer == "yes"
    new_session
  else
    puts "Ok. Would you like to review a previous session?"
    prev_session = gets.chomp.downcase

    if prev_session == "yes"
      #GET AND REVIEW PREVIOUS SESSIONS
    elsif prev_session == "no"
      puts "Well if you don't want a new session, and you don't want to review your old sessions, then you're SOL."
    else
      puts "That's not an acceptable response."
      first_question
    end
  end
end

def new_session
  distractions = 0

  puts "What would you like to do (add track(s) or review tracks)?"
  request = gets.chomp.downcase

  case request
  when "add track"
    distractions += 1
    puts "You have #{distractions} tracks in this session."
  when "add tracks"
    puts "How many times have you been distracted since we last met?"
    distractions += gets.chomp.to_i
    puts "You have #{distractions} tracks."
  when "review tracks"
    puts distractions
  end

  pretty_time = Time.now.strftime('%Y-%m-%d-%H%M%S')

  File.open("session-#{pretty_time}.track", 'w') do |file|
    file.write(distractions)
  end
end

first_question
