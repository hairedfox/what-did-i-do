import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["name", "times", "notes"]

  initialize() {
    console.log("Go here")
  }

  addActivity() {
    const url = new URL('/user_activities', `${window.location.origin}`)

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
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      body: JSON.stringify(activity)
    })
    .then(res => res.json())
    .then((res) => {
      const listItem = this.createActivityElement(res.data.data)
      $('.activity-group').append(listItem)
      this.clearTarget()
    })
  }

  createActivityElement(data) {
    const firstDiv = document.createElement('div')
    firstDiv.classList.add('w-100')

    const activityName = document.createElement('strong')
    activityName.innerHTML = data.attributes.name

    const activityTimes = document.createElement('span')
    activityTimes.classList = 'badge bg-success rounded-pill ms-3'
    activityTimes.innerHTML = data.attributes.times

    const activityNotes = document.createElement('div')
    activityNotes.innerHTML = data.attributes.notes

    firstDiv.appendChild(activityName)
    firstDiv.appendChild(activityTimes)
    firstDiv.appendChild(activityNotes)

    const secondDiv = document.createElement('div')
    secondDiv.classList.add('d-flex')

    const inputNumber = document.createElement('input')
    inputNumber.type = 'number';
    inputNumber.classList.add('form-control')
    inputNumber.placeholder = "Number"

    const plusButton = document.createElement('button')
    plusButton.classList = 'btn btn-success ms-2 btn-plus align-self-center'
    plusButton.innerHTML = '+'

    const minusButton = document.createElement('button')
    minusButton.classList = 'btn btn-danger ms-2 btn-plus align-self-center'
    minusButton.innerHTML = '-'

    secondDiv.appendChild(inputNumber)
    secondDiv.appendChild(plusButton)
    secondDiv.appendChild(minusButton)

    const listItem = document.createElement('li')
    listItem.classList = 'd-flex justify-content-between activity-item w-50'
    listItem.appendChild(firstDiv)
    listItem.appendChild(secondDiv)

    return listItem;
  }

  clearTarget() {
    this.nameTarget.value = ''
    this.notesTarget.value = ''
    this.timesTarget.value = ''
  }
}
