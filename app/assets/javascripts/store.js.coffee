# http://emberjs.com/guides/models/defining-a-store/
DS.RESTAdapter.reopen
  namespace: 'api'

App.Store = DS.Store.extend
  adapter: '_ams'
