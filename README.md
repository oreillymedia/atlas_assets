Atlas Assets
============

This Ruby gem holds all shared assets used throughout the O'Reilly Atlas platform. 

Style Guide
-----------

For reference, visit the online [style guide documentation](http://atlas-assets.herokuapp.com) included in this gem.

Usage
-----

To use in a new Rails application, add the gem to your Gemfile, and include the gem manifest file:

```javascript
*= require atlas_assets
```

You can also require individual files by name.

```javascript
*= require icons
```

Adding new styles
-----------------

If you need to add or change styles in this gem, first get a local environment set up:

1. Clone down the gem to your local machine
2. Run `bundle` from the gem root
3. Fire up jekyll by running `jekyll serve --watch`

You now have the site running in your browser on `localhost:4000`. Now follow these steps to add and document the new style(s):

1. Create you own feature branch
2. Implement your style by tweaking the CSS and checking the documentation on `localhost:4000`. Do not work from the specific Atlas Rails app by updating the gem constantly. All new styles should be developed using the `docs`, and should be independent from a particular application.
3. When ready, bump the version number in `lib/atlas_assets/version.rb`, and send a pull request to the master branch.
4. Bump the `atlas_assets` gem version in your apps `Gemfile`, run `bundle`, and use the new styles.