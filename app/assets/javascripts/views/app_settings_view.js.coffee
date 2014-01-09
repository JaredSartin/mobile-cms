App.AppSettingsView = Ember.View.extend
  didInsertElement: ->
    $('#app-icon').fileupload(
      dataType: 'json'
      url: "/api/apps/#{@controller.get('id')}/icon"
      start: =>
        Pace.options.ghostTime = 3000
        Pace.restart()
      stop: =>
        Pace.stop()
      done: (e, data) =>
        @controller.set('iconUrl', data.response().result.app.icon_url)
    )

  willDestroyElement: ->
