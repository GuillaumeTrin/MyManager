const initNavbar = () => {
  const menu = document.querySelector(".nav-icon");
  const sidebar = document.querySelector(".sidebar");
  if (!menu)
    return
  menu.addEventListener("click", (event) => {
    sidebar.classList.toggle("sidebar-default");
  });
}

export { initNavbar }
