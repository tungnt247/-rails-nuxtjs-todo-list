export default async function ({ app }) {
  if (!app.$auth.loggedIn) {
      return
  }

  const auth = app.$auth
  const authStrategy = auth.strategy.name

  if(authStrategy === 'facebook'){
    const token = auth.getToken(authStrategy).substr(7)
    try {
      const response = await app.$axios.$post('/facebook_login', {
        fb_token: token
      })
      auth.setToken('local', 'Bearer ' + response.token)
    } catch (e) {
      console.log(e)
    }
  }
}
