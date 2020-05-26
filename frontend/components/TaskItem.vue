<template>
  <v-card color="blue-grey darken-2">
    <v-toolbar>
      <v-text-field
        @keyup.enter="updateTask($event, task)"
        :value="task.content"
        name="content"
        lable="content"
        :disabled="task.completed"
        :rules="contentRule"
        placeholder="Content..."
        validate-on-blur
      />
      <v-btn @click.prevent="updateTaskStatus(task)" icon nuxt to="/" v-if="!task.completed">
        <v-icon color="teal darken-2">done</v-icon>
      </v-btn>
      <v-btn @click.prevent="deleteTask(task.id)" icon nuxt to="/">
        <v-icon color="red darken-2">clear</v-icon>
      </v-btn>
    </v-toolbar>
  </v-card>
</template>

<script>
export default {
  props: {
    tasks: Array,
    task: Object,
    contentRule: Array
  },
  methods: {
    updateTask(event, task) {
      this.$axios.$patch(`tasks/${task.id}`, {
        task: { content: task.content }
      })
      .then(response => {          
        task.content = event.target.value
        event.target.blur()
      })
      .catch(error => { this.error = error });
    },
    updateTaskStatus(task) {
      this.$axios.$patch(`tasks/${task.id}/complete`)
      .then((response) => {
        task.completed = response.completed
        let sortedTasks = this.tasks.sort(function (a, b) {
          return b.id -a.id
        })
        this.$nuxt.$emit('update-task-status', sortedTasks)
      })
      .catch(error => { this.error = error });
    },
    deleteTask(task_id) {
      this.$axios.$delete(`tasks/${task_id}`)
      .then(() => {
        const newTaskList = this.tasks.filter((task) => task.id != task_id)
        this.$nuxt.$emit('delete-task', newTaskList)
      })
      .catch((error) => { this.error = error })
    }
  }
}
</script>
