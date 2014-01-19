App.AppSettingsView = Ember.View.extend
  didInsertElement: ->
    $('#app-icon').fileupload(
      dataType: 'json'
      url: "/api/apps/#{@controller.get('id')}/icon"
      start: =>
        @Flash.set('notice', "Uploading, please wait...")
        Pace.options.ghostTime = 5000
        Pace.restart()
      stop: =>
        Pace.stop()
      done: (e, data) =>
        @Flash.set('success', "Icon has been updated!")
        iconTypes = ['appleSmallestIcon', 'appleSmallIcon', 'appleMediumIcon', 'appleLargeIcon', 'androidIcon']
        Pace.options.ghostTime = 5000
        Pace.restart()
        for iconType in iconTypes
          @controller.set(iconType, data.response().result.app[iconType.underscore()])
    )

  willDestroyElement: ->
    $('#app-icon').fileupload('destroy')
