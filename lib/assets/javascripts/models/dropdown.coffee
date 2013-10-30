classes.Dropdown = Backbone.Model.extend
  intialize: () ->
    @

  setLabel: (label) ->
    @set('label',@get(label))