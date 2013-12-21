App.Page = DS.Model.extend
  app: DS.belongsTo 'app', async: true, inverse: 'pages'
  parent: DS.belongsTo 'page', async: true, inverse: 'children'
  children: DS.hasMany 'page', async: true, inverse: 'parent'
  order: DS.attr 'number'
  title: DS.attr 'string'
  body: DS.attr 'string'
