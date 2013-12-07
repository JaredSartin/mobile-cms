App.Router.reopen
  location: 'history'

App.Router.map ()->
  @resource('admin', ->
    @route('dashboard', path: '/')
    @resource('client', path: '/app/:client_id', ->
      @route('dashboard')
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
