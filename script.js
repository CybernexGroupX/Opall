console.log('Opall application loaded');

// Modal Logic
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'flex';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Close modal when clicking outside
window.onclick = function (event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = 'none';
    }
}

// Form Submission Handler (Mock)
document.getElementById('signup-form').addEventListener('submit', function (e) {
    e.preventDefault();
    alert('Înscriere trimisă cu succes! (Demo)');
    closeModal('modal-inscrieri');
});
