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

1. If needed, add a new `.css.scss` file in the `lib/assets` folder, and include it in the `atlas_assets.css` manifest. If you don't need a new file, add your CSS to an existing file.
2. If needed, add a new `.md` file in the `docs/_posts` folder. If you don't need a new file, add your markup to an existing file.
3. Implement your style by tweaking the CSS and checking the documentation on `localhost:4000`. Do not work from the specific Atlas Rails app by updating the gem constantly. All new styles should be developed using the `docs`, and should be independent from a particular application.
4. When ready, bump the version number in `lib/atlas_assets/version.rb`, and push the changes to the master branch.
5. Bump the `atlas_assets` gem version in your apps `Gemfile`, run `bundle`, and use the new styles.