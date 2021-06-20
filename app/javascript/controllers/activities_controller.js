import { Controller } from "stimulus"
import { csrfToken, serverUrl, buildElement } from '../utils/common'

export default class extends Controller {
  static targets = ["name", "times", "notes", "changedTimes"]

  connect() {
    super.connect()
  }

  addActivity() {
    const url = new URL('/user_activities/', `${serverUrl()}`)

    const activity = {
      name: this.nameTarget.value,
      times: this.timesTarget.value,
      notes: this.notesTarget.value
    }

    if (activity.name === "" || activity.times === "") return

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken()
      },
      body: JSON.stringify(activity)
    })
    .then(res => res.json())
    .then((res) => {
      const { attributes } = res.data
      const { name } = attributes

      if (this.checkExistUserAction(name)) {
        const list = this.elementList().filter(e => e.name === name)

        if (list.length > 0) {
          const { times, notes } = attributes
          const item = list.pop()
          $(item.element).find('.activity-times').text(times)
          $(item.element).find('.activity-notes').text(notes)
        }
      } else {
        const listItem = this.createActivityElement(res.data)
        $('.activity-group').append(listItem)
      }
    })
    .then(() => this.clearTarget())
  }

  removeActivity() {
    const id = $(this.element).find('.activity-id').data('id')
    const url = new URL(`/user_activities/${id}`, serverUrl())

    fetch(url, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken()
      }
    })
    .then(_ => $(this.element).remove())
  }

  changeTimes(event) {
    const operatorClass = event.target.classList.value
    const numberToChange = operatorClass.includes('plus') ? (+this.changedTimesTarget.value) : (-this.changedTimesTarget.value)
    const id = $(this.element).find('.activity-id').data('id')
    const url = new URL(`/user_activities/${id}`, serverUrl())
    const obj = {
      times: numberToChange,
    }

    const that = this

    fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken()
      },
      body: JSON.stringify(obj)
    })
    .then(res => res.json())
    .then(res => {
      const { attributes } = res.data
      $(that.element).find('.activity-times').text(attributes.times)
      that.changedTimesTarget.value = ''
    })
  }

  createActivityElement(data) {
    const activityName = buildElement('strong',
      {
        html: data.attributes.name,
        classList: 'activity-name'
      })

    const activityTimes = buildElement('span',
      {
        html: data.attributes.times,
        classList: 'badge bg-success rounded-pill ms-3 activity-times'
      })

    const activityNotes = buildElement('div',
      {
        html: data.attributes.notes,
        classList: 'activity-notes'
      })

    const firstDiv = buildElement('div',
      {
        classList: 'w-100 activity-id',
        data: {
          id: data.id
        },
        children: [activityName, activityTimes, activityNotes]
      })

    const inputNumber = buildElement('input',
      {
        placeholder: 'Number',
        classList: 'form-control',
        type: 'number',
        data: {
          target: 'activities.changedTimes'
        }
      })

    const plusButton = buildElement('button',
      {
        html: '<i class="fas fa-plus">',
        classList: 'btn btn-success ms-2 btn-plus align-self-center',
        data: {
          action: 'click->activities#changeTimes'
        }
      })

    const minusButton = buildElement('button',
      {
        html: '<i class="fas fa-minus">',
        classList: 'btn btn-warning ms-2 btn-plus align-self-center',
        data: {
          action: 'click->activities#changeTimes'
        }
      })

    const secondDiv = buildElement('div',
      {
        classList: 'd-flex',
        children: [inputNumber, plusButton, minusButton]
      })

    const removeButton = buildElement('button',
      {
        html: '<i class="fas fa-trash">',
        classList: 'btn btn-danger ms-2 btn-remove align-self-center',
        data: {
          action: 'click->activities#removeActivity'
        }
      })

    const listItem = buildElement('li',
      {
        classList: 'd-flex justify-content-between activity-item',
        data: {
          controller: this.identifier,
        },
        children: [firstDiv, secondDiv, removeButton]
      })

    return listItem;
  }

  clearTarget() {
    this.nameTarget.value = ''
    this.notesTarget.value = ''
    this.timesTarget.value = ''
  }

  elementList() {
    return $('.activity-group').children()
      .map((_, element) => {
        return {
          name: $(element).find('.activity-name').text(),
          element
        }
      })
      .toArray()
  }

  checkExistUserAction(name) {
    const listNames = this.elementList().map(e => e.name)

    return listNames.includes(name)
  }
}
