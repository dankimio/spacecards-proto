export default class {
  // Helper to retrieve CSRF token and other data from meta tags
  static getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute('content')
  }
}
