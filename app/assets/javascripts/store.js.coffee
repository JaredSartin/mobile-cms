# http://emberjs.com/guides/models/defining-a-store/
DS.RESTAdapter.reopen
  namespace: 'api'

App.Store = DS.Store.extend
  adapter: '_ams'

DS.Store.reopen
  properDeleteChild: (model, callback) ->
    Ember.Logger.warn("Deleting child model using workaround - please investigate: https://github.com/emberjs/data/issues/1308 - Still present 10/18/13")
    model.eachRelationship (name, relationship) ->
      if relationship.kind is "belongsTo"
        inverse = relationship.parentType.inverseFor(name)
        parent = model.get(name)
        parent.get(inverse.name).removeObject model  if inverse and parent

    model.deleteRecord()
    if callback
      model.save().then ->
        callback()
    else
      model.save()
