module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3,
      features: {
        'nesting-rules': true
      }
    }),
    require('tailwindcss')('./app/javascript/css/tailwind.js')
  ]
}
