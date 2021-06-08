import { Controller } from "stimulus"

export default class extends Controller {
  // your logic (controller actions)
  static targets = ['title', 'previewTitle', 'content', 'previewContent', 'image', 'previewImage', 'date', 'previewDate'];

  connect() {
    console.log("cocuoc")
    // this.ddebug = this.element.dataset.debug
    console.log(this)
  }

  gettitle() {
    const titleContent = this.titleTarget.value;
    this.previewTitleTarget.innerText = titleContent
  }

  getcontent() {
    const contentContent = this.contentTarget.value;
    this.previewContentTarget.innerText = contentContent;
  }

  getimage() {
    console.log(this)
    const file = this.imageTarget.files[0]
    console.log(URL.createObjectURL(file))
    this.previewImageTarget.src = URL.createObjectURL(file)
  }

  getdate() {
    const dateContent = this.dateTarget.value;
    const date = new Date(Date.parse(dateContent));
    const option_date = date.toLocaleString('fr-FR', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });
    const option_time = date.toLocaleString('fr-FR', {
      hour: 'numeric',
      minute: 'numeric',
    });
    this.previewDateTarget.innerText = `${option_date}, at ${option_time}`;
  }
}
