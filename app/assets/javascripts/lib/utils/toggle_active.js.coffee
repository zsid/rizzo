define ["jquery"], ($) ->

  class ToggleActive

    LISTENER = '#js-card-holder'

    constructor: ->
      @listen()
      @_addInitialState()


    listen: ->
      $('.js-toggle-active').on 'click', (event) =>
        $el = $(event.target)
        @_updateClasses($el)
        @broadcast($el)
        false

      $(LISTENER).on ':toggleActive/update', (e, target) =>
        @_updateClasses($(target))

    broadcast: ($el) ->
      $el.trigger(':toggleActive/click', {active: $el.hasClass('is-active')})


    # Private

    _addInitialState: ->
      $('.js-toggle-active').each ->
        $el = $(@)
        $($el.data('toggleTarget')).addClass('is-not-active')
        $el.addClass('is-not-active') if $el.data('toggleMe')

    _updateClasses: ($el) ->
      classList = 'is-active is-not-active '
      classList += $el.data('toggleClass') if $el.data('toggleClass')

      $el.toggleClass(classList) if $el.data('toggleMe')
      $($el.data('toggleTarget')).toggleClass(classList)