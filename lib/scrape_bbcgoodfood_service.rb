require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

class ScrapeBbcGoodFoodService # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    results = []
    # Create URL with the user's keyword
    url = "https://www.bbcgoodfood.com/search/recipes?q=#{@keyword}"
    # Download the page for the URL
    html = open(url).read
    # Parse the first 5 results on the page
    results_doc = Nokogiri::HTML(html, nil, 'utf-8')
    results_doc.search('.standard-card-new__article-title').first(5).each do |element|
      recipe_url = "https://www.bbcgoodfood.com#{element.attribute('href').value}"
      # Open the recipe page!
      recipe_page = Nokogiri::HTML(open(recipe_url).read, nil, 'utf-8')
      # Grab the name, description from each result
      title = recipe_page.search('.masthead__title.heading-1').text.strip
      description = recipe_page.search('.editor-content').first.text.strip
      prep_time = recipe_page.search('.icon-with-text__children .body-copy-small.list-item')
                                    .first.text.strip
      difficulty = recipe_page.search('.icon-with-text.masthead__skill-level').text.strip

      results << Recipe.new(name: title,
                            description: description,
                            prep_time: prep_time,
                            difficulty: difficulty)
    end
    results
  end
end
