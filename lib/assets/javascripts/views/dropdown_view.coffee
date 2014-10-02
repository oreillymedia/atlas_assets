classes.DropdownView = Backbone.View.extend
  tagName: "div"
  className: "dropdown"
  backboneClass: "DropdownView"

  initialize: (opts) ->
    if !@collection?
      @collection = new classes.DropdownCollection
    @opts = _.extend({width: "100%", disable_search_threshold: 4}, opts)
    @template = JST["dropdown"];
    @listenTo(@collection, 'add', @render)
    @collection.each (model) =>
      @set_default(model)

  set_default: (model) ->
    if model.get('value') is "#{@opts.default_to}" or  model.get('label') is "#{@opts.default_to}"
      model.set('selected', 'selected')

  add: (params) ->
    model = params.model
    model.set 'value', model.get(@opts.value || 'value') || model.get(@opts.label || 'label')
    model.set 'label', model.get(@opts.label || 'label')
    @collection.add(model)
    @set_default(model)
    @render().el

  render: () ->
    @rendered = true;
    @$el.html(this.template(_.extend(@opts, {models: @collection.toJSON()})))

    this.delegateEvents();
    @$('.dropdown-list').chosen({width: @opts.width, disable_search_threshold: @opts.disable_search_threshold}).change((e,selected) =>
      model = @collection.find (m) ->
        selected.selected is m.get('value')
      this.trigger(app.events.SELECT, model)
    )
    @

  set_selected: (model) ->
    @collection.each (m) ->
      if (model is m)
        m.set('selected', 'selected')
      else
        m.unset('selected')
    @render().el

  get_selected: () ->
    @collection.find (model) => @$('select').val() is model.get('value')