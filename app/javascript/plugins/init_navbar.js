const initNavbar = () => {
  const menu = document.querySelector(".nav-icon");

  menu.addEventListener("click", (event) => {
    const sidebar = document.querySelector(".sidebar");
    sidebar.classList.toggle("sidebar-default");
  });
}

export { initNavbar }
