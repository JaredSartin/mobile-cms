App.Router.reopen
  location: 'history'

App.Router.map ()->
  @resource('admin', ->
    @route('dashboard', path: '/')
    @resource('app', path: '/app/:app_id', ->
      @route('dashboard', path: '/')
      @route('settings')
      @resource('sections', ->
        @route('new')
      )
      @resource('section', path: '/section/:section_id', ->
        @route('show', path: '/')
        @route('edit')
      )
    )
  )
