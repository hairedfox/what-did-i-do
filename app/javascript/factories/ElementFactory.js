class ElementFactory {
  constructor(tag, options) {
    this.element = document.createElement(tag)
    this.options = options
  }

  addClass() {
    if (this.options.classList && this.options.classList.length > 0) {
      this.element.classList = this.options.classList
    }
    return this
  }

  addData() {
    if (!this.options.data) return this

    Object.keys(this.options.data).forEach((key) => {
      this.element.dataset[key] = this.options.data[key]
    })

    return this
  }

  addHTML() {
    if (!!this.options.html) {
      this.element.innerHTML = this.options.html
    }

    return this
  }

  addPlaceholder() {
    if (this.options.placeholder && this.options.placeholder.length > 0) {
      this.element.placeholder = this.options.placeholder
    }

    return this
  }

  addType() {
    if (this.options.type && this.options.type.length > 0) {
      this.element.type = this.options.type
    }

    return this
  }

  addChildren() {
    if (!!this.options.children) {
      this.options.children.forEach(child => this.element.appendChild(child))
    }

    return this
  }
}

export default ElementFactory
