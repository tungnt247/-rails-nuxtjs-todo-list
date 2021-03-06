export default {
  methods: {
    isLoggedIn () {
      return this.$auth.$state.loggedIn
    }
  }
}
