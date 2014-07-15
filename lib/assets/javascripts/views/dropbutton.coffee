classes.DropButtonView = Backbone.View.extend
  initialize: (opts) ->
    if !opts.models? and !opts.collection?
      throw new Error("DropButtonView must be instantiated with either a collection or array of objects")
    else if opts.collection?
      @collection = opts.collection
    else
      @collection = new Backbone.Collection(opts.models)

    @main_button = @get_main()

    @template = JST["templates/dropbutton"]

  get_main: ->
    d = @collection.find (m) -> m.get('main') is true
    if d?
      d
    else
      @collection.first()

  render: ->
    @$el.html @template({
      main_button: @main_button,
      collection: @collection.toJSON()
    })
    @
