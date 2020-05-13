<template>
  <v-layout>
    <v-flex>
      <v-card v-if="isLoggedIn()">
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
      <v-card v-else>
        <v-alert type="error" :value="error">
          {{ error }}
        </v-alert>
        <v-card-text>
          <v-form>
            <v-text-field v-model="email" label="Email" />
            <v-text-field v-model="password" label="Password" type="password" />
          </v-form>
          <v-card-actions>
            <v-btn @click="login">
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
      email: '',
      password: '',
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
