###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "blog/{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "posts/:title.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "layouts/blog-layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :disqus do |d|
  d.shortname = 'qbaylogic' # Replace with your Disqus shortname.
end

require 'pygments'

activate :syntax

module ::Middleman::Syntax::Highlighter
  def self.highlight(code, language=nil, opts={})
    Pygments.highlight(code, lexer: language, :options => {:lineanchors => 'line', :cssclass => 'codehilite'})
  end
end

set :markdown_engine, :kramdown

#------------------------------------------------------------------------
# Configuration variables specific to each project
#------------------------------------------------------------------------
SITE_NAME                       = 'QBayLogic'
URL_ROOT                        = 'http://qbaylogic.com'

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :gzip

  # activate :minify_html

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets
end
