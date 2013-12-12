App.User = DS.Model.extend
  email: DS.attr 'string'
  apps: DS.hasMany 'app', async: true, inverse: 'user'
