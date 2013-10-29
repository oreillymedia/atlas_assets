require 'handlebars_assets'
HandlebarsAssets::Config.template_namespace = 'JST'
Sprockets.append_path HandlebarsAssets.path
require "jekyll-assets"