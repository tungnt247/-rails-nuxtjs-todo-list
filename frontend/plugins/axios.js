export default function ({ app }) {
  app.$axios.onRequest((config) => {
    const token = app.$auth.getToken('local')
    token && (config.headers.Authorization = token)
    return config
  })
}
