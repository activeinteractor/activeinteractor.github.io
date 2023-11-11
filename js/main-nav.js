document.addEventListener('DOMContentLoaded', (event) => {
  console.log('DomContentLoaded')
  const $navbarBurgers = Array.prototype.slice.call(document.getElementById('navbar-toggle'), 0);
  $navbarBurgers.forEach( el => {
    el.addEventListener('click', () => {
      const target = el.dataset.target;
      const $target = document.getElementById(target);
      $target.classList.toggle('hidden');
    });
  });
});
