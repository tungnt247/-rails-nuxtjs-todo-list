
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
      local1: {
        _scheme: 'local',
        endpoints: {
          login: { url: '/login', method: 'post', propertyName: 'token' },
          user: { url: '/user' },
          logout: false
        },
        tokenRequired: true,
        tokenType: 'Bearer'
      },
      local2: {
        _scheme: 'local',
        endpoints: {
          login: { url: '/facebook_login', method: 'post', propertyName: 'token' },
          user: { url: '/user' },
          logout: false
        },
        tokenRequired: true,
        tokenType: 'Bearer'
      }
    },
    redirect: {
      login: '/login',
      logout: '/login',
      home: '/',
      callback: '/login'
    },
    resetOnError: true
  },
  build: {
    extend (config, ctx) {
    }
  },
  router: {
    middleware: ['auth']
  }
}
