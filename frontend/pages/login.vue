<template>
  <v-layout align-center justify-center>
    <v-flex xs12 sm8 md4>
      <v-card class="elevation-12">
        <v-toolbar dark color="primary">
          <v-toolbar-title>Login form</v-toolbar-title>
          <v-spacer />
        </v-toolbar>
        <v-alert type="error" :value="error">
          {{ error }}
        </v-alert>
        <v-card-text>
          <v-form>
            <v-text-field v-model="email" prepend-icon="email" name="email" label="email" type="text" />
            <v-text-field
              id="password"
              v-model="password"
              prepend-icon="lock"
              name="password"
              label="Password"
              type="password"
            />
          </v-form>
          <v-card-actions>
            <v-btn href="https://www.facebook.com/v7.0/dialog/oauth?client_id=251620079257199&redirect_uri=http://localhost:8000/login&state={loggedIn=true}&scope=public_profile,email">
              Log in with facebook
            </v-btn>
            <v-spacer />
            <v-btn color="primary" @click="login">
              Log in
            </v-btn>
          </v-card-actions>
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  data () {
    return {
      email: 'tung@yopmail.com',
      password: '123123123',
      error: null
    }
  },
  mounted () {
    if (!this.$route.query.code) {
      return
    } else {
      this.loginWithFacebook()
    }
  },
  methods: {
    login () {
      this.$auth.loginWith('local1', {
        data: {
          email: this.email,
          password: this.password
        }
      }).catch((e) => { this.error = e + '' })
    },
    loginWithFacebook () {
      const code = this.$route.query.code

      this.$auth.loginWith('local2', {
        data: {
          facebook_code: code
        }
      })
      this.$router.replace('/')
    }
  }
}
</script>
