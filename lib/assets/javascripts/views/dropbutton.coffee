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
    @others = @collection.reject (m) =>
      m is @main_button

    @subviews = []
    _.each @others, (other) =>
      view = new classes.DropButtonItemView({model:other})
      @subviews.push view

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
      main_button: @main_button.toJSON(),
      others: @others
    })

    drop = new Drop
      target: @$el.find('.drpb-btn')[0]
      content: '<div class="drpb-drops">SUP</div>'
      position: 'bottom left'
      openOn: 'click'


    _.each @subviews, (view) =>
      $('.drpb-drops').append(view.render().el)

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