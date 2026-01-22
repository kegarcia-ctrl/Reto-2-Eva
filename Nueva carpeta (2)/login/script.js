document.addEventListener('DOMContentLoaded', () => {
    
    // Seleccionamos los elementos
    const btnSignIn = document.querySelector('.signin-active');
    const btnSignUp = document.querySelector('.signup-inactive');
    const formSignIn = document.querySelector('.form-signin');
    const formSignUp = document.querySelector('.form-signup');
    const frame = document.querySelector('.frame');

    // Función para ir a Registro
    btnSignUp.addEventListener('click', () => {
        // Cambiar estilos de la cabecera
        btnSignIn.classList.remove('signin-active');
        btnSignIn.classList.add('signup-inactive');
        btnSignUp.classList.remove('signup-inactive');
        btnSignUp.classList.add('signin-active');

        // Mover los formularios
        formSignIn.classList.add('form-signin-left');
        formSignUp.classList.add('form-signup-left');
        
        // (Opcional) Aumentar un poco la altura si el form de registro es más largo
        frame.style.height = "650px"; 
    });

    // Función para volver a Inicio de Sesión
    btnSignIn.addEventListener('click', () => {
        // Cambiar estilos de la cabecera
        btnSignIn.classList.remove('signup-inactive');
        btnSignIn.classList.add('signin-active');
        btnSignUp.classList.remove('signin-active');
        btnSignUp.classList.add('signup-inactive');

        // Mover los formularios de vuelta
        formSignIn.classList.remove('form-signin-left');
        formSignUp.classList.remove('form-signup-left');
        
        // Restaurar altura original
        frame.style.height = "575px"; 
    });
});