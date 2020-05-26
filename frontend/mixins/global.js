export const loginMixin = {
  methods: {
    isLoggedIn () {
      return this.$auth.$state.loggedIn
    }
  }
}
