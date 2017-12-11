const categoryChoices = document.querySelectorAll(".category-choice label");
const userChoices = document.querySelectorAll(".user-choice");

function changeClass(e) {
  categoryChoices.forEach(choice => choice.parentNode.parentNode.classList.remove("active"))
  e.currentTarget.parentNode.parentNode.classList.toggle("active");
}

function changeUserClass(e) {
  e.currentTarget.classList.toggle("active-user");
  const id = e.currentTarget.id;
  const input = document.getElementById("project_user_ids_" + id);
  input.checked = true;
  console.log(input)
}

function selectCategory() {
  categoryChoices.forEach(choice => choice.addEventListener("click", changeClass));
}

function selectUsers() {
  userChoices.forEach(choice => choice.addEventListener("click", changeUserClass));
}

export { selectCategory };

export { selectUsers };
