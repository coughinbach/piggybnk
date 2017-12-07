const categoryChoices = document.querySelectorAll(".category-choice label");
const userChoices = document.querySelectorAll(".user-choice label");

function changeClass(e) {
  categoryChoices.forEach(choice => choice.parentNode.parentNode.classList.remove("active"))
  e.currentTarget.parentNode.parentNode.classList.toggle("active");
}

function changeUserClass(e) {
  e.currentTarget.parentNode.parentNode.classList.toggle("active-user");
}

function selectCategory() {
  categoryChoices.forEach(choice => choice.addEventListener("click", changeClass));
}

function selectUsers() {
  userChoices.forEach(choice => choice.addEventListener("click", changeUserClass));
}

export { selectCategory };

export { selectUsers };
