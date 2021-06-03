import { Controller } from "stimulus"

export default class extends Controller {
  // your logic (controller actions)
  static targets = ['title', 'previewTitle', 'content', 'previewContent', 'image', 'previewImage'];

  gettitle() {
    const titleContent = this.titleTarget.value;
    this.previewTitleTarget.innerText = titleContent
  }

  getcontent() {
    const contentContent = this.contentTarget.value;
    this.previewContentTarget.innerText = contentContent;
  }

  getimage() {
    console.log(this.imageTarget.files);
    const file = this.imageTarget.files[0]
    console.log(URL.createObjectURL(file))
    console.log(this.previewImageTarget)
    this.previewImageTarget.src = URL.createObjectURL(file)
  }
}
