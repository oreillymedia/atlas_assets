classes.DropdownView = Backbone.View.extend
  tagName: "div"
  className: "dropdown"
  backboneClass: "DropdownView"

  initialize: (opts) ->
    if !@collection?
      @collection = new classes.DropDownCollection
    @opts = _.extend({width: "100%", disable_search_threshold: 2}, opts)
    @template = JST["dropdown"];
    @listenTo(@collection, 'add', @render)
    @collection.each (model) =>
      @set_default(model)

  set_default: (model) ->
    model.set('selected', 'selected') if model.get('label') is @opts.default_to

  add: (params) ->
    model = params.model
    model.set 'label', model.get(params.label || 'label')
    @collection.add(model)
    @set_default(model)
    @render().el

  render: () ->
    @rendered = true;
    @$el.html(this.template(_.extend(@opts, {models: @collection.toJSON()})))

    this.delegateEvents();
    @$('.dropdown-list').chosen({width: @opts.width, disable_search_threshold: @opts.disable_search_threshold}).change((e,selected) =>
      model = @collection.find (m) ->
        selected.selected is m.get('label')
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
    @collection.find (model) => @$('select').val() is model.get('label')