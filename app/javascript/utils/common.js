export function csrfToken() {
  return $('meta[name="csrf-token"]').attr('content')
}

export function serverUrl() {
  return window.location.origin
}
