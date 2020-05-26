<template>
  <task-card :task-list="tasks" />
</template>

<script>
import TaskCard from '~/components/TaskCard'

export default {
  components: { TaskCard },
  data () {
    return {
      tasks: []
    }
  },
  async mounted () {
    await this.updateTaskList()
  },
  created () {
    this.$nuxt.$on('create-task', (response) => {
      this.tasks = [response, ...this.tasks]
    })

    this.$nuxt.$on('delete-task', (response) => {
      this.tasks = response
    })

    this.$nuxt.$on('update-task-status', (response) => {
      this.tasks = response.sort(function(a, b) {
        return (a.completed === b.completed)? 0 : a.completed? 1 : -1
      })
    })
  },
  methods: {
    async updateTaskList () {
      this.tasks = await this.$axios.$get('tasks')
    }
  }
}
</script>
