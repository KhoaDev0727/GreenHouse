document.getElementById('userIcon').addEventListener('click', function (event) {
    event.preventDefault();
    const userMenu = document.getElementById('userMenu');
    userMenu.style.display = userMenu.style.display === 'block' ? 'none' : 'block';
});


window.addEventListener('click', function (event) {
    if (!event.target.matches('#userIcon') && !event.target.matches('.fas.fa-user')) {
        document.getElementById('userMenu').style.display = 'none';
    }
});

