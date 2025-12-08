/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/main/webapp/WEB-INF/**/*.jsp',
    './src/main/webapp/public/**/*.js',
    './src/main/webapp/tailwindcss/**/*.js',
  ],
  theme: {
    extend: {},
    screens: {
      'md': '600px',
      'lg': '1200px',
    },
    container: {
      center: true,
      padding: {
        DEFAULT: '20px',
        'lg': '0px',
      },
      screens: {
        'lg': '1356px',
      },
    },
  },
  plugins: [],
}

