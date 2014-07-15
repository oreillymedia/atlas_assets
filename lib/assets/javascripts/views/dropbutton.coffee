classes.DropButtonView = Backbone.View.extend
  events:
    'click .drpb-main a': 'click_main'

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

  click_main: ->
    if _.isFunction @main_button.get('onclick')
      @main_button.get('onclick')()
      false

  functionator: (v) -> if _.isFunction(v) then "#" else v

  render: ->
    @$el.html @template({
      functionator: @functionator,
      main_button: @main_button,
      others: @collection.reject((m) => m is @main_button )
    })
    @
