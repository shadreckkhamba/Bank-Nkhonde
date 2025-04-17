document.addEventListener("turbo:load", function () {
  const profileButton = document.getElementById("profile-button");
  const dropdownMenu = document.getElementById("dropdown-menu");

  if (profileButton && dropdownMenu) {
    const newProfileButton = profileButton.cloneNode(true);
    profileButton.parentNode.replaceChild(newProfileButton, profileButton);

    const caret = newProfileButton.querySelector(".caret");

    newProfileButton.addEventListener("click", function () {
      dropdownMenu.classList.toggle("show");
      caret.classList.toggle("flipped");
    });

    document.addEventListener("click", function (event) {
      if (!newProfileButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
        dropdownMenu.classList.remove("show");
        caret.classList.remove("flipped");
      }
    });
  }
});