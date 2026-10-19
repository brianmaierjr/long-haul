(function () {
  'use strict';
  var root = document.documentElement;
  var toggle = document.getElementById('theme-toggle');
  if (toggle) {
    toggle.addEventListener('click', function () {
      var next = root.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
      if (next === 'dark') root.removeAttribute('data-theme');
      else root.setAttribute('data-theme', 'light');
      try { localStorage.setItem('cybersec-theme', next); } catch (error) {}
    });
  }
  var input = document.getElementById('post-search');
  if (input) {
    var cards = Array.prototype.slice.call(document.querySelectorAll('[data-filter-item]'));
    var count = document.getElementById('search-count');
    var empty = document.getElementById('empty-results');
    function normalize(value) {
      return (value || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim();
    }
    function filter() {
      var query = normalize(input.value);
      var hits = 0;
      cards.forEach(function (card) {
        var show = normalize(card.getAttribute('data-search')).indexOf(query) > -1;
        card.hidden = !show;
        if (show) hits++;
      });
      if (count) count.textContent = hits + (hits === 1 ? ' artículo' : ' artículos');
      if (empty) empty.hidden = hits !== 0;
    }
    input.addEventListener('input', filter);
  }
})();
