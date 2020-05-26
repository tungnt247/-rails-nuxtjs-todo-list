<template>
  <div class="card-header">
    <div class="card-title">
      <h2 class="headline align-center">TODO LIST</h2>
    </div>
    <v-alert v-if="error" type="error" :value="error">{{ error }}</v-alert>
    <v-card-text>
      <v-text-field
        @keyup.enter="createTask"
        v-model="content"
        :rules="contentRule"
        placeholder="Content..."
        validate-on-blur
      />
    </v-card-text>
  </div>
</template>

<script>
export default {
  data() {
    return {
      error: null,
      content: ''
    }
  },
  props: {
    contentRule: Array
  },
  methods: {
    createTask() {
      this.$axios.$post("tasks", {
        task: { content: this.content }
      })
      .then(response => {
        this.content = ""
        this.$nuxt.$emit('create-task', response)
      })
      .catch(error => { this.error = error });
    }
  }
}
</script>

<style>
.card-title {
  padding: 10px;
}
</style>
