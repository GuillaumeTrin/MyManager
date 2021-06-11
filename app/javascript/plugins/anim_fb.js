// Wrap every letter in a span
const animFb = () => {
const textWrapper = document.querySelector('.ml2');
if (!textWrapper)
    return
textWrapper.innerHTML = textWrapper.textContent.replace(/\S/g, "<span class='letter'>$&</span>");

anime.timeline()
  .add({
    targets: '.ml2 .letter',
    scale: [4,1],
    opacity: [0,1],
    translateZ: 0,
    easing: "easeOutExpo",
    duration: 950,
    delay: (el, i) => 70*i
  })

}

export { animFb }
