// Navigation Logic
const navItems = document.querySelectorAll('.sidebar-nav li');
const tabContents = document.querySelectorAll('.tab-content');

navItems.forEach(item => {
    item.addEventListener('click', () => {
        const tabId = item.getAttribute('data-tab');
        switchTab(tabId);
    });
});

function switchTab(tabId) {
    // Update Sidebar
    navItems.forEach(nav => {
        nav.classList.remove('active');
        if (nav.getAttribute('data-tab') === tabId) {
            nav.classList.add('active');
        }
    });

    // Update Content
    tabContents.forEach(content => {
        content.classList.remove('active');
        if (content.id === tabId) {
            content.classList.add('active');
        }
    });

    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// WhatsApp Integration
const WA_NUMBER = "6287865307837";

function redirectToWA(message) {
    const encodedMessage = encodeURIComponent(message);
    window.open(`https://wa.me/${WA_NUMBER}?text=${encodedMessage}`, '_blank');
}

function orderService(serviceName) {
    const message = `Halo Admin JokiPro, saya tertarik dengan layanan *${serviceName}*. Bisa minta info lebih lanjut?`;
    redirectToWA(message);
}

// Price Calculator Logic
const taskType = document.getElementById('task-type');
const deadlineRange = document.getElementById('deadline');
const deadlineVal = document.getElementById('deadline-val');
const totalPriceDisplay = document.getElementById('total-price');

function calculatePrice() {
    const type = taskType.value;
    const difficulty = parseFloat(document.querySelector('input[name="difficulty"]:checked').value);
    const deadline = parseInt(deadlineRange.value);
    
    let basePrice = 50000;

    // Base price by type
    switch(type) {
        case 'basic': basePrice = 50000; break;
        case 'web-basic': basePrice = 150000; break;
        case 'web-complex': basePrice = 500000; break;
        case 'mobile': basePrice = 750000; break;
        case 'ai': basePrice = 400000; break;
    }

    // Deadline multiplier (shorter = more expensive)
    // 14 days = 1x, 1 day = 2x
    const deadlineMultiplier = 1 + (14 - deadline) / 13;
    
    const total = basePrice * difficulty * deadlineMultiplier;
    
    // Format to IDR
    totalPriceDisplay.innerText = Math.round(total).toLocaleString('id-ID');
}

// Event Listeners for Calculator
if (taskType) {
    taskType.addEventListener('change', calculatePrice);
    deadlineRange.addEventListener('input', (e) => {
        deadlineVal.innerText = e.target.value;
        calculatePrice();
    });
    document.querySelectorAll('input[name="difficulty"]').forEach(radio => {
        radio.addEventListener('change', calculatePrice);
    });
    
    // Initial calculation
    calculatePrice();
}

function orderFromCalc() {
    const type = taskType.options[taskType.selectedIndex].text;
    const deadline = deadlineRange.value;
    const price = totalPriceDisplay.innerText;
    
    const message = `Halo Admin JokiPro,\n\nSaya sudah cek estimasi di dashboard:\n- Layanan: *${type}*\n- Deadline: *${deadline} Hari*\n- Estimasi: *Rp ${price}*\n\nBisa dibantu proses lebih lanjut?`;
    redirectToWA(message);
}

// Search Functionality (Mockup)
const searchInput = document.querySelector('.search-bar input');
if (searchInput) {
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            const query = searchInput.value;
            alert(`Mencari "${query}"... (Fitur ini sedang dalam pengembangan)`);
        }
    });
}

// Notification Mockup
const notifyBtn = document.querySelector('.btn-icon');
if (notifyBtn) {
    notifyBtn.addEventListener('click', () => {
        alert('Tidak ada notifikasi baru saat ini.');
    });
}
