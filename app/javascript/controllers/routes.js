// app/assets/javascripts/routes.js

document.addEventListener("DOMContentLoaded", () => {
  const favoriteButtons = document.querySelectorAll('.favorite-button');

  favoriteButtons.forEach(button => {
    button.addEventListener('ajax:success', (event) => {
      const [data, _status, xhr] = event.detail;
      const isFavorited = JSON.parse(xhr.response).favorited;

      if (isFavorited) {
        button.innerHTML = "Remove from Favorites";
        button.setAttribute('turbo-method', 'delete');
      } else {
        button.innerHTML = "Add to Favorites";
        button.setAttribute('turbo-method', 'post');
      }
    });
  });
});
