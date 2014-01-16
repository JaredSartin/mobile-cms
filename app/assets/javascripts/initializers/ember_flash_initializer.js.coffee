Ember.Flash = {}

Ember.Application.initializer
  name: 'flashMessage'
  initialize: (container, application) ->
    container.register('tool:flash', Ember.FlashObject)
    container.injection('route', 'Flash', 'tool:flash')
    container.injection('controller', 'Flash', 'tool:flash')
    container.injection('view', 'Flash', 'tool:flash')

Ember.Flash.MessageContainerView = Ember.ContainerView.extend
  classNames: ['flashes']
  classNameBindings: ['hasViews::hide']
  hasViews: ( -> !Ember.isEmpty(@get('childViews')) ).property('childViews')

Ember.Flash.MessageView = Ember.View.extend
  didInsertElement: ->
    setTimeout =>
      @removeFromParent()
    , 3000
  classNames: ['alert']
  classNameBindings: ['msgTypeClass']

  msg: ''

  msgType: 'notice'
  msgTypeClass: ( ->
    @get('flashMap')[@get('msgType')]
  ).property('msgType')

  msgIcon: ( ->
    switch @get('msgType')
      when 'success'
        "<span class='glyphicon glyphicon-ok'></span>"
      else
        ''
  ).property('msgType')
  
  defaultTemplate: Ember.Handlebars.compile('{{{view.msgIcon}}}{{view.msg}}')

  flashMap:
    {
      error: 'alert-danger'
      success: 'alert-success'
      notice: 'alert-info'
      warning: 'alert-warning'
    }

Ember.FlashObject = Ember.Object.extend
  init: ->
    # Setup message types
    for type in ['error', 'success', 'notice', 'warning']
      Ember.defineProperty(@, type,
        Ember.computed( (type, msg) ->
          message =
            type: type
            message: msg
          @get('messages').pushObject(message)
        )
      )

    flashesContainer = Ember.Flash.MessageContainerView.create()
    flashesContainer.append()
    @set 'flashes', flashesContainer

  messages: []
  flashes: null

  createMessageView: ( ->
    messages = @get('messages')
    @set('messages', []) if !Ember.isEmpty(messages)
    flashes = @get('flashes')
    for message in messages
      flashes.pushObject Ember.Flash.MessageView.create(msg: message.message, msgType: message.type)
  ).observes('messages.[]')
