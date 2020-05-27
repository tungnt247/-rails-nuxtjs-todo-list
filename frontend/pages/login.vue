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
  methods: {
    login () {
      this.$auth.loginWith('local', {
        data: {
          email: this.email,
          password: this.password
        }
      }).catch((e) => { this.error = e + '' })
    }
  }
}
</script>
