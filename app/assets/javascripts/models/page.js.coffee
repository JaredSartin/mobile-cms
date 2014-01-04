App.Page = DS.Model.extend
  app: DS.belongsTo 'app', async: true, inverse: 'pages'
  page: DS.belongsTo 'page', async: true, inverse: 'children'
  children: DS.hasMany 'page', async: true, inverse: 'page'
  order: DS.attr 'number'
  title: DS.attr 'string'
  body: DS.attr 'string'

  parent: ( (key, value)->
    if arguments.length > 1
      @set('page', value)
    @get('page')
  ).property('page')

  sortedChildren: ( ->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: ["order"]
      content: @get('children')
  ).property('model.children.@each.order', 'model.children.@each')
