App.App = DS.Model.extend
  user: DS.belongsTo 'user', async: true, inverse: 'apps'
  name: DS.attr 'string'
  subdomain: DS.attr 'string'
  cname: DS.attr 'string'
  home_page: DS.belongsTo 'page', async: true
  pages: DS.hasMany 'page', async: true
