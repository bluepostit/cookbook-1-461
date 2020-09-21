class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? '[x]' : '[ ]'
      puts "#{index + 1}. #{done} #{recipe.name} [#{recipe.prep_time}]" \
        + " (#{recipe.difficulty}) #{recipe.description}"
    end
  end

  def ask_for(thing)
    puts "Please enter the #{thing}"
    print '> '
    gets.chomp
  end

  def ask_for_index
    ask_for('number').to_i - 1
  end
end
