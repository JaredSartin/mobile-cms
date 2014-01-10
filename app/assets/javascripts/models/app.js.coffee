App.App = DS.Model.extend
  user: DS.belongsTo 'user', async: true, inverse: 'apps'
  name: DS.attr 'string'
  shortname: DS.attr 'string'
  cname: DS.attr 'string'
  homepage: DS.belongsTo 'page', async: true
  pages: DS.hasMany 'page', async: true
  appleSmallestIcon: DS.attr 'string'
  appleSmallIcon: DS.attr 'string'
  appleMediumIcon: DS.attr 'string'
  appleLargeIcon: DS.attr 'string'
  androidIcon: DS.attr 'string'
