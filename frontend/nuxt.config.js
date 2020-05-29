
export default {
  mode: 'universal',
  head: {
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  loading: { color: '#fff' },
  css: [
  ],
  plugins: [
    { src: '~/plugins/axios' },
    { src: '~/plugins/localStorage.js', ssr: false }
  ],
  buildModules: [
    // '@nuxtjs/eslint-module',
  ],
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/dotenv',
    '@nuxtjs/auth',
    '@nuxtjs/vuetify'
  ],
  axios: {
    host: 'localhost',
    port: 3000,
    prefix: '/api/v1'
  },
  auth: {
    strategies: {
      local: {
        endpoints: {
          login: { url: '/login', method: 'post', propertyName: 'token' },
          user: { url: '/user' },
          logout: false
        },
        tokenRequired: true,
        tokenType: 'Bearer'
      },
      facebook: {
        client_id: '251620079257199',
        userinfo_endpoint: false,
        scope: ['public_profile', 'email'],
        redirect_uri: 'http://localhost:8000/'
      }
    },
    redirect: {
      login: '/login',
      logout: '/login',
      home: '/',
      callback: '/login'
    },
    resetOnError: true,
    plugins: ['~/plugins/auth']
  },
  build: {
    extend (config, ctx) {
    }
  },
  router: {
    middleware: ['auth']
  }
}
