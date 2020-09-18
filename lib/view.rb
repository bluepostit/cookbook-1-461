class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name} (#{recipe.description})"
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
