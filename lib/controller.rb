require 'open-uri'
require 'nokogiri'
require_relative 'recipe'
require_relative 'view'
require_relative 'scrape_bbcgoodfood_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # get recipes from the cookbook
    recipes = @cookbook.all
    # send them to the view to display them
    @view.display(recipes)
  end

  def create
    # get recipe name from view
    name = @view.ask_for('name')
    # get recipe description from view
    description = @view.ask_for('description')
    # get recipe prep time
    prep_time = @view.ask_for('preparation time')
    # get recipe difficulty
    difficulty = @view.ask_for('difficulty')
    # create a new Recipe instance/object
    recipe = Recipe.new(name: name,
                        description: description,
                        prep_time: prep_time,
                        difficulty: difficulty)
    # add it to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # list the recipes
    list
    # get recipe index from the view
    index = @view.ask_for_index
    # tell cookbook to delete recipe at the given index
    @cookbook.remove_recipe(index)
  end

  def import
    # Ask user for keyword
    ingredient = @view.ask_for('ingredient')
    service = ScrapeBbcGoodFoodService.new(ingredient)
    # Returns an array of RECIPE objects!
    results = service.call
    # Display the results in a numbered list
    @view.display(results)
    # Ask the user which recipe to import (by number/index)
    index = @view.ask_for_index
    # Find the recipe which corresponds to the index
    recipe = results[index]
    # Add it to the cookbook (repository)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    list
     # get recipe index from the view
    index = @view.ask_for_index
    # find the recipe
    @cookbook.mark_recipe_as_done(index)
  end
end
