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

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

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

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def post_url(article_title)
    blog.articles.find { |article| article.title.downcase == article_title.downcase }.url
    rescue
    ""
  end
end

#------------------------------------------------------------------------
# Configuration variables specific to each project
#------------------------------------------------------------------------
SITE_NAME                       = 'QBayLogic'
URL_ROOT                        = 'http://qbaylogic.com'
AWS_BUCKET                      = 'qbaylogic-com'
AWS_CLOUDFRONT_DISTRIBUTION_ID  = 'E3Q8URRQ23NCSH'


#------------------------------------------------------------------------
# Common configuration below here, should not need to be changed.
#------------------------------------------------------------------------


# Sent in on CLI by rake task
#------------------------------------------------------------------------
AWS_ACCESS_KEY                  = ENV['AWS_ACCESS_KEY']
AWS_SECRET                      = ENV['AWS_SECRET']

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

# https://github.com/fredjean/middleman-s3_sync
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = AWS_BUCKET # The name of the S3 bucket you are targeting. This is globally unique.
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket. (S3 no longer requires this, dummy input?)
  s3_sync.aws_access_key_id          = AWS_ACCESS_KEY
  s3_sync.aws_secret_access_key      = AWS_SECRET
  s3_sync.delete                     = false # We delete stray files by default.
  # s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  # s3_sync.path_style                 = true
  # s3_sync.reduced_redundancy_storage = false
  # s3_sync.acl                        = 'public-read'
  # s3_sync.encryption                 = false
  # s3_sync.prefix                     = ''
  # s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end

caching_policy 'image/png', max_age: 31536000
caching_policy 'image/jpeg', max_age: 31536000
caching_policy 'text/css', max_age: 31536000
caching_policy 'application/javascript', max_age: 31536000

# https://github.com/andrusha/middleman-cloudfront
activate :cloudfront do |cf|
  cf.access_key_id                    = AWS_ACCESS_KEY
  cf.secret_access_key                = AWS_SECRET
  cf.distribution_id                  = AWS_CLOUDFRONT_DISTRIBUTION_ID
  # cf.filter = /\.html$/i
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-77540661-1' # Replace with your property ID.
end
