App.App = DS.Model.extend
  user: DS.belongsTo 'user', async: true, inverse: 'apps'
  name: DS.attr 'string'
  shortname: DS.attr 'string'
  cname: DS.attr 'string'
  homepage: DS.belongsTo 'page', async: true
  pages: DS.hasMany 'page', async: true
  iconUrl: DS.attr 'string'
