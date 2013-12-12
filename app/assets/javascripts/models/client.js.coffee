App.App = DS.Model.extend
  user: DS.belongsTo 'user', async: true, inverse: 'apps'
  name: DS.attr 'string'
  subdomain: DS.attr 'string'
  cname: DS.attr 'string'
