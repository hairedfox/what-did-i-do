import ElementFactory from '../factories/ElementFactory'

export function csrfToken() {
  return $('meta[name="csrf-token"]').attr('content')
}

export function serverUrl() {
  return window.location.origin
}

export function buildElement(tag, options = {}) {
  return new ElementFactory(tag, options)
    .addClass()
    .addData()
    .addHTML()
    .addPlaceholder()
    .addType()
    .addChildren()
    .element
}
