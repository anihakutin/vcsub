/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css',
  ],
  theme: {
    extend: {
      keyframes: {
        'fade-in-down': {
          '0%': {
            opacity: '0',
            transform: 'translate(-50%, -1rem)'
          },
          '100%': {
            opacity: '1',
            transform: 'translate(-50%, 0)'
          },
        },
        'fade-out-up': {
          '0%': {
            opacity: '1',
            transform: 'translate(-50%, 0)'
          },
          '100%': {
            opacity: '0',
            transform: 'translate(-50%, -1rem)'
          },
        }
      },
      animation: {
        'fade-in-down': 'fade-in-down 0.3s ease-out',
        'fade-out-up': 'fade-out-up 0.3s ease-in forwards'
      }
    },
  },
  plugins: [],
} 