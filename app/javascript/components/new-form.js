const choices = document.querySelectorAll(".category-choice label");

function changeClass(e) {
  choices.forEach(choice => choice.parentNode.parentNode.classList.remove("active"))
  e.currentTarget.parentNode.parentNode.classList.toggle("active");
}

function selectCategory() {
  choices.forEach(choice => choice.addEventListener("click", changeClass));
}

export { selectCategory };
