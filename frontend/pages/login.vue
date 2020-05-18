<template>
  <v-layout align-center justify-center>
    <v-flex xs12 sm8 md4>
      <v-card v-if="isLoggedIn()" class="elevation-12">
        <v-alert type="error" :value="error">
          {{ error }}
        </v-alert>
        <v-card-text>
          Logged in as {{ $auth.$state.user.email }}
        </v-card-text>
        <v-card-actions>
          <v-btn @click="logout">
            Log out
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-card v-else class="elevation-12">
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
import loginMixin from '~/mixins/global'

export default {
  mixins: [loginMixin],
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
      }).then((response) => {
        this.$auth.setUser(response.data.user)
        this.$auth.setToken('local', response.data.auth_token)
      }).catch((e) => { this.error = e + '' })
    },
    logout () {
      this.$auth.logout().catch((e) => { this.error = e + '' })
    }
  }
}
</script>
