require_relative 'recipe'
require_relative 'view'

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
    # create a new Recipe instance/object
    recipe = Recipe.new(name, description)
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
end
