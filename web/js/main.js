let currentSlide = 0;
const slides = document.querySelectorAll('.slide');
const sliderWrapper = document.getElementById('sliderWrapper');
const dotContainer = document.querySelector('.dot-navigation');
let slideInterval;

// Tạo các chấm điều hướng
slides.forEach((_, index) => {
    const dot = document.createElement('div');
    dot.classList.add('dot');
    if (index === 0) dot.classList.add('active');
    dot.addEventListener('click', () => goToSlide(index));
    dotContainer.appendChild(dot);
});

const dots = document.querySelectorAll('.dot');

function updateDots() {
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
}

function goToSlide(n) {
    currentSlide = n;
    sliderWrapper.style.transform = `translateX(-${currentSlide * 100}%)`;
    updateDots();
    resetInterval();
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
    goToSlide(currentSlide);
}

function resetInterval() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

// Bắt đầu tự động chuyển slide
slideInterval = setInterval(nextSlide, 5000);

// Ngừng tự động chuyển khi di chuột vào
document.querySelector('.slider-container').addEventListener('mouseenter', () => {
    clearInterval(slideInterval);
});

// Tiếp tục tự động chuyển khi di chuột ra
document.querySelector('.slider-container').addEventListener('mouseleave', () => {
    resetInterval();
});