classes.DropButtonView = Backbone.View.extend
  events:
    'click .drpb-main a': 'click_main'

  className: 'drpb'

  initialize: (opts) ->
    if !opts.models? and !opts.collection?
      throw new Error("DropButtonView must be instantiated with either a collection or array of objects")
    else if opts.collection?
      @collection = opts.collection
    else
      @collection = new Backbone.Collection(opts.models)

    @template = JST["templates/dropbutton"]
    @main_button = @get_main()
    @others = @collection.reject((m) => m is @main_button)
    @subviews = []

    _.each @others, (other) =>
      view = new classes.DropButtonItemView({model:other})
      @subviews.push view

  # Set the main element for the button, if nothing is specified opt for the
  # first model.
  get_main: ->
    d = @collection.find (m) -> m.get('main') is true
    if d?
      d
    else
      @collection.first()

  # Listener for a click event on the main button
  click_main: ->
    if _.isFunction @main_button.get('onclick')
      @main_button.get('onclick')()
      false

  functionator: (v) -> if _.isFunction(v) then "#" else v

  render: ->
    @$el.html @template({
      functionator: @functionator,
      main_button: @main_button.toJSON(),
      others: @others
    })

    # Render each item as a view because a click event could be a function not
    # just a link.
    _.each @subviews, (view) =>
      @$('.drpb-drop').append(view.render().el)

    # Sets up dropdown on small button
    @drop = new Drop
      target: @$el.find('.drpb-btn')[0]
      content: @$('.drpb-drop')[0]
      position: 'bottom right'
      openOn: 'click'
      tetherOptions:
        offset: '2px -1px'

    @

classes.DropButtonItemView = Backbone.View.extend
  events:
    'click a': 'click'

  click: ->
    if _.isFunction(@model.get('onclick'))
      @model.get('onclick')()
      false

  functionator: (v) -> if _.isFunction(v) then "#" else v

  initialize: (opts) ->
    @model = opts.model
    @template = JST['templates/dropbutton_item']

  render: ->
    @$el.html(@template({
      functionator: @functionator,
      model: @model.toJSON()
    }))
    @