(function () {
  var root = document.documentElement;
  var media = window.matchMedia("(prefers-color-scheme: dark)");
  var storageKey = "theme";

  function storedTheme() {
    try {
      var value = localStorage.getItem(storageKey);
      return value === "light" || value === "dark" ? value : null;
    } catch (error) {
      return null;
    }
  }

  function systemTheme() {
    return media.matches ? "dark" : "light";
  }

  function currentTheme() {
    var value = root.getAttribute("data-theme");
    return value === "light" || value === "dark" ? value : systemTheme();
  }

  function syncMeta(theme) {
    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta) {
      meta.setAttribute(
        "content",
        theme === "dark" ? "#161614" : "#fcfbf8",
      );
    }
  }

  function apply(theme) {
    root.setAttribute("data-theme", theme);
    syncMeta(theme);
  }

  function updateButton() {
    var button = document.querySelector(".theme-toggle");
    if (!button) return;
    var next = currentTheme() === "dark" ? "light" : "dark";
    button.setAttribute("aria-label", "Switch to " + next + " theme");
    button.setAttribute("title", "Switch to " + next + " theme");
  }

  apply(storedTheme() || systemTheme());

  document.addEventListener("DOMContentLoaded", function () {
    var button = document.querySelector(".theme-toggle");
    if (button) {
      button.addEventListener("click", function () {
        var next = currentTheme() === "dark" ? "light" : "dark";
        apply(next);
        try {
          localStorage.setItem(storageKey, next);
        } catch (error) {}
        updateButton();
      });
    }
    updateButton();
  });

  if (media.addEventListener) {
    media.addEventListener("change", function () {
      if (!storedTheme()) {
        apply(systemTheme());
        updateButton();
      }
    });
  }
})();
