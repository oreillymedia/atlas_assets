# Two ways to createa a Select dropdown
#
# Start with a Backbone Collection and a specified label
#
# select_view = new classes.SelectView({
#   collection:some_collection,
#   label: "name"
# })
#
# Start with an array
#
# select_view = new classes.SelectView({
#   values: ["rune","steve","zach"]
# })

class classes.SelectView extends Backbone.View

  defaults: {label: 'label', value: 'value', sort : true}

  initialize: (options) ->
    @rendered = false
    
    console.log "in select intialize"

    @label = if options.label then options.label else @defaults.label
    @value = if options.value then options.value else false
    @default_to= if options.default_to then options.default_to else false
    @sort = if options.sort? then options.sort else @defaults.sort
    @helper =options.helper if options.helper?
    
    # The select view needs a collection.
    if !@collection
      console.log "creating collection"
      @collection = @collection_from_values(options.values)
    else if @collection.length > 0
      console.log "using existing collection"
      t = @
      @collection.each (model) ->
        t.set_model_attributes(model)
    else 
      console.log "no collection or values"
      throw new Error "Select needs either a collection or an array of values"

    console.log @collection
     
    @template = JST["templates/select"]
    @listenTo(@collection, 'add', @add_model)
    @listenTo(@collection, 'remove', @render)
    @listenTo(@, 'rendered', @bind_select)

  collection_from_values: (values) ->
    @collection = new Backbone.Collection(_.map(values, (v) ->
      return {"label": v}
    ))
    @collection.comparator = "label" if @sort
    return @collection.sort() if @sort
    return @collection
    

  add_model: (m) ->
    @set_model_attributes(m)
    select_el = @$el.find('select').first()
    value = if m.get('value') then "value='#{m.get('value')}'" else ""
    label = if m.get('label') then "label='#{m.get('label')}'" else ""
    select_el.append("<option #{value}>#{label}</option>")

    sort_by_name = (a, b) ->
      a.innerHTML.toLowerCase().localeCompare(b.innerHTML.toLowerCase())

    options = select_el.children().get()
    options = options.sort(sort_by_name) if @sort
    for opt in options
      select_el.append(opt)

  set_model_attributes: (model) =>
    console.log "set_model_attributes"
    model.set('label',model.get(@label))
    model.set('value',model.get(@value)) if @value
    if @default_to and @value and @default_to is model.get(@value)
      model.set('selected',true) 
    else if @default_to and !@value and @default_to is model.get(@label)
      model.set('selected',true) 
    else

  bind_select: ->
    t = @
    @rendered = true
    @select = new Select({
      el: @$el.find('select')[0]
      className: 'select-theme-atlas'
    })

    @select.on('change', (v) ->
      if t.value
        selected_model = t.collection.find((model) -> model.get(t.value) is v.value)
      else
        selected_model = t.collection.find((model) -> model.get(t.label) is v.value)
      
      t.trigger('change', selected_model)
    )

  get_value: -> @select.value
  get_model: ->
    value = @select.value
    if model.get('value')
      @collection.find (model) => model.get('value') is value
    else
      @collection.find (model) => model.get('label') is value

  set: (value) -> @select.change(value)

  render: =>
    @collection.comparator = if @value then "value" else "label"
    models = if @sort then @collection.sort().models else @collection.models
    @$el.html(@template({models:models, helper:@helper})).addClass("select-dropdown")
    @trigger('rendered') if !@rendered

