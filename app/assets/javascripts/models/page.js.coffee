App.Page = DS.Model.extend
  app: DS.belongsTo 'app', async: true, inverse: 'pages'
  page: DS.belongsTo 'page', async: true, inverse: 'children'
  children: DS.hasMany 'page', async: true, inverse: 'page'
  order: DS.attr 'number'
  title: DS.attr 'string'
  body: DS.attr 'string'
  active: DS.attr 'boolean'
  startDate: DS.attr 'string'
  endDate: DS.attr 'string'

  humanStart: ( (k,v) ->
    if v and moment(v).isValid()
      @set('startDate', moment(v).format())
    else if v == ''
      @set('startDate', '')

    current = @get('startDate')
    if !Ember.isEmpty(current) and moment(current).isValid()
      moment(current).format('L')
    else
      ""
  ).property('startDate', 'humanStart')

  humanEnd: ( (k,v) ->
    if v and moment(v).isValid()
      @set('endDate', moment(v).format())
    else if v == ''
      @set('endDate', '')

    current = @get('endDate')
    if !Ember.isEmpty(current) and moment(current).isValid()
      moment(current).format('L')
    else
      ""
  ).property('endDate', 'humanEnd')

  dateRange: ( ->
    active = @get('active')
    start = @get('startDate')
    end = @get('endDate')
    if start or end
      sDisplay = if start then "From: #{@get('humanStart')}" else ""
      eDisplay = if end then "Until: #{@get('humanEnd')}" else ""
      aDisplay = if active then "(active)" else "(inactive)"
      "#{sDisplay} #{eDisplay} #{aDisplay}"
    else
      'Always Displayed'
  ).property('startDate', 'endDate', 'active')

  parent: ( (key, value)->
    if arguments.length > 1
      @set('page', value)
    @get('page')
  ).property('page')

  sortedChildren: Ember.computed.sort('children', (c1, c2) ->
    if c1.get('order') > c2.get('order')
      1
    else if c1.get('order') < c2.get('order')
      -1
    else
      0
  )
