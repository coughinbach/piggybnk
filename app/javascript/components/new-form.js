const categoryChoices = document.querySelectorAll(".category-choice label");
const userChoices = document.querySelectorAll(".user-fake-label");

function changeClass(e) {
  categoryChoices.forEach(choice => choice.parentNode.parentNode.classList.remove("active"))
  e.currentTarget.parentNode.parentNode.classList.toggle("active");
}

function changeUserClass(e) {
  const checkboxId = e.currentTarget.dataset.checkboxTarget;
  const checkboxTarget = document.getElementById(checkboxId);
  if (checkboxTarget.checked === true) {
    checkboxTarget.checked = false;
  } else {
    checkboxTarget.checked = true;
  }
  const pictureTargetId = e.currentTarget.dataset.pictureTarget;
  const pictureTarget = document.getElementById(pictureTargetId);
  pictureTarget.classList.toggle("active-user");
}

function selectCategory() {
  categoryChoices.forEach(choice => choice.addEventListener("click", changeClass));
}

function selectUsers() {
  userChoices.forEach(choice => choice.addEventListener("click", changeUserClass));
}

export { selectCategory };

export { selectUsers };
